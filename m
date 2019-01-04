From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Fri, 4 Jan 2019 11:57:52 +0100
Message-ID: <b0013590-fc0b-320f-3c11-9fb0deb9bb86@hartkopp.net>
References: <20190104091353.2438-1-socketcan@hartkopp.net>
 <20190104103147.GE28932@unicorn.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190104103147.GE28932@unicorn.suse.cz>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Michal Kubecek <mkubecek@suse.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 1/4/19 11:31 AM, Michal Kubecek wrote:
> On Fri, Jan 04, 2019 at 10:13:53AM +0100, Oliver Hartkopp wrote:
>> Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a CAN
>> frame modification rule that makes the data length code a higher value than
>> the available CAN frame data size. In combination with a configured checksum
>> calculation where the result is stored relatively to the end of the data
>> (e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in
>> skb_shared_info) can be rewritten which finally can cause a system crash.
>>
>> Michael Kubecek suggested to drop frames that have a DLC exceeding the
>> available space after the modification process and provided a patch that can
>> handle CAN FD frames too. Within this patch we also limit the length for the
>> checksum calculations to the maximum of Classic CAN data length (8).
>>
>> CAN frames that are dropped by these additional checks are counted with the
>> CGW_DELETED counter which indicates misconfigurations in can-gw rules.
>>
>> This fixes CVE-2019-3701.
>>
>> Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
>> Reported-by: Marcus Meissner <meissner@suse.de>
>> Suggested-by: Michal Kubecek <mkubecek@suse.cz>
>> Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
>> ---
>>   net/can/gw.c | 36 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/can/gw.c b/net/can/gw.c
>> index faa3da88a127..180c389af5b1 100644
>> --- a/net/can/gw.c
>> +++ b/net/can/gw.c
>> @@ -416,13 +416,31 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>>   	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
>>   		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
>>   
>> -	/* check for checksum updates when the CAN frame has been modified */
>> +	/* Has the CAN frame been modified? */
>>   	if (modidx) {
>> -		if (gwj->mod.csumfunc.crc8)
>> -			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
>> +		/* get available space for the processed CAN frame type */
>> +		int max_len = nskb->len - offsetof(struct can_frame, data);
>>   
>> -		if (gwj->mod.csumfunc.xor)
>> -			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
>> +		/* dlc may have changed, make sure it fits to the CAN frame */
>> +		if (cf->can_dlc > max_len)
>> +			goto out_delete;
>> +
>> +		/* check for checksum updates in classic CAN length only */
>> +		if (gwj->mod.csumfunc.crc8) {
>> +			if (cf->can_dlc > 8)
>> +				goto out_delete;
>> +			else
>> +				(*gwj->mod.csumfunc.crc8)
>> +					(cf, &gwj->mod.csum.crc8);
>> +		}
>> +
>> +		if (gwj->mod.csumfunc.xor) {
>> +			if (cf->can_dlc > 8)
>> +				goto out_delete;
>> +			else
>> +				(*gwj->mod.csumfunc.xor)
>> +					(cf, &gwj->mod.csum.xor);
>> +		}
>>   	}
>>   
>>   	/* clear the skb timestamp if not configured the other way */
>> @@ -434,6 +452,14 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>>   		gwj->dropped_frames++;
>>   	else
>>   		gwj->handled_frames++;
>> +
>> +	return;
>> +
>> +out_delete:
>> +	/* delete frame due to misconfiguration */
>> +	gwj->deleted_frames++;
>> +	kfree_skb(nskb);
>> +	return;
>>   }
>>   
>>   static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
>> -- 
>> 2.19.2
>>
> 
> Except for the "8" vs "CAN_MAX_DLEN" issue discussed in v1, looks good
> to me.

Thanks for the review!

Best regards,
Oliver
