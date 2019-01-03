From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Thu, 3 Jan 2019 20:31:51 +0100
Message-ID: <9e4dfe7c-42cc-3dba-763a-23ce4e10389b@hartkopp.net>
References: <20190103122634.2530-1-socketcan@hartkopp.net>
 <20190103140121.GB28932@unicorn.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190103140121.GB28932@unicorn.suse.cz>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Michal Kubecek <mkubecek@suse.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Michal,

On 1/3/19 3:01 PM, Michal Kubecek wrote:
> On Thu, Jan 03, 2019 at 01:26:34PM +0100, Oliver Hartkopp wrote:
(..)
>>   	/* check for checksum updates when the CAN frame has been modified */
>>   	if (modidx) {
>> +		/* ensure DLC boundaries after the different mods */
>> +		if (cf->can_dlc > 8)
>> +			cf->can_dlc = 8;
>> +
>>   		if (gwj->mod.csumfunc.crc8)
>>   			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
>>   
> 
> IMHO "8" should rather be "CAN_MAX_DLEN". I can see two problems with
> your patch:
> 
> 1. If I understand the code correctly, canfd_frame packets (which allow
> larger lenth) are also processed by this code path.

In fact the can-gw frame modification and checksum functionalities lack 
CAN FD support today.

If you take a look into the netlink API only struct can_frame's can be 
supplied for frame modifications - and so are the checks e.g. in 
cgw_chk_csum_parms().

The given patch fixes the problem as described in the commit message in 
all stable Linux versions since can-gw appeared in Linux 3.2.

Anyway your modification makes definitely sense, as it allows to process 
CAN FD frames in struct canfd_frame as long as only data is modified 
that is also available in a struct can_frame. AND - as a bonus - it 
should work for stable 3.2 too, when CAN FD was not even introduced. 
Good idea!

If it's ok for you I would like to re-send the patch together with the 
CVE number and would like to credit your suggestion in the text and with 
"Suggested-by:".

> As reported to security list, cgw_csum_xor_rel() with negative offset can
> then rewrite e.g. frag_list pointer in skb_shared_info, crashing the
> system. With unprivileged user namespaces, this can be exploited by any
> regular user.

This is wrong! First there is no negative offset, as can_dlc is a u8 
value. Therefore you can try to hit content in the tail of the skb only.
Second can-gw rules can only be configured by *root* and not by any 
regular user - and finally it is definitely not namespace related.

So the user root can configure a can-gw rule to shoot into the skb tail 
to kill the machine. I can imagine better things to do when I'm already 
root ;-)

Thanks & best regards,
Oliver

> 
> Rather than distinguishing between can_frame and canfd_frame, check if
> resulting payload length does not reach beyond nskb->len which is what we
> are actually interested in.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>   net/can/gw.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index faa3da88a127..87b7043e3250 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -418,6 +418,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   
>   	/* check for checksum updates when the CAN frame has been modified */
>   	if (modidx) {
> +		int max_dlc = nskb->len - offsetof(struct can_frame, data);
> +
> +		/* dlc may have changed, check the new value */
> +		if (cf->can_dlc > max_dlc) {
> +			gwj->dropped_frames++;
> +			kfree_skb(nskb);
> +			return;
> +		}
> +
>   		if (gwj->mod.csumfunc.crc8)
>   			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
>   
> 
