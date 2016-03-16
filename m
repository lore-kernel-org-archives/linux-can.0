From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Wed, 16 Mar 2016 10:47:59 +0100
Message-ID: <56E92BCF.1080508@hartkopp.net>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
 <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:56771 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934964AbcCPJsO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2016 05:48:14 -0400
In-Reply-To: <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Ramesh / Marc,

On 16.03.2016 08:45, Ramesh Shanmugasundaram wrote:

>>>>
>>>> What happens if the user only defines:
>>>>
>>>> 	"ip link set can0 up type can bitrate 1000000"
>>>>
>>>> instead of
>>>>
>>>> 	"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
>>>>
>>>> ??
>>>
>>> This is not possible isn't it? netlink already does a sanity check on
>> dbitrate before bring up of a FD node.
>>
>> No. It's not netlink but the open_candev() function which does the sanity
>> check - the function you call in rcar_canfd_open():
>
> Yes, my intention is to mention that this config is not possible but I misused netlink instead of the exact function name.
>
>>
>>   > +
>>   > +static int rcar_canfd_open(struct net_device *ndev)  > +{
>>   > +	struct rcar_canfd_channel *priv = netdev_priv(ndev);
>>   > +	struct rcar_canfd_global *gpriv = priv->gpriv;
>>   > +	int err;
>>   > +
>>   > +	/* Peripheral clock is already enabled in probe */
>>   > +	err = clk_prepare_enable(gpriv->can_clk);
>>   > +	if (err) {
>>   > +		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
>> err);
>>   > +		goto out_clock;
>>   > +	}
>>
>> I wonder if it makes sense to add
>>
>> if (!priv->data_bittiming.bitrate) {
>>
>> 	/* copy arbitration bitrate to data bitrate registers */
>>
>> }
>>
>> here instead of urging the user to provide an identical data bitrate to
>> configure a working CAN2.0 setup.
>>
>>   > +
>>   > + err = open_candev(ndev);
>>   > + if (err) {
>>   > + netdev_err(ndev, "open_candev() failed, error %d\n", err);  > + goto
>> out_can_clock;  > + }  > +
>>
>> As we omitted to force the user to provide 'fd on' at configuration time
>> - why should we force users to provide a second bitrate for a CAN2.0
>> operation??
>
> We are not forcing "fd on" because it is still a consistent configuration w.r.t mode, mtu & bitrates.

But the default value is "fd off" - even if no one provides this configuration 
option all the time.

So it's some kind of 'silent' knowledge to take a look at the MTU?
That's bad too.

>>
>> This looks more straight forward to me and hides the fact of handling a
>> CANFD-only controller differently to a CAN2.0 or CAN2.0/CANFD controller
>> setup.
>
> I think we are going back to the original discussion. To quote you from earlier thread
>
> ---
> When you have a CAN FD /capable/ controller the idea is:
>
> "ip link set can0 up type can bitrate 1000000"
>
> The controller is in CAN2.0 mode:
>
> 1. It can send and receive CAN2.0 frames @1MBit/s.
> 2. The MTU is set to 16 (sizeof(struct can_frame)) ; CAN_CTRLMODE_FD is unset.
> 3. The CAN controller is not CAN FD tolerant (will produce error frames)
> ---
>
> This is the normal config setup for a CAN 2.0 controller too. Assuming we are hiding the CAN FD only mode, points 2 & 3 are broken isn't it? Not sure why we want to hide CAN FD only mode? It adds more ambiguity only. What do you think?

Yes. You are right. Up to that statement I was not really aware of a 
CANFD-only CAN controller setup and how to handle it best.

But now that we have one - and after our discussions - I would suggest to have 
a similar user experience for CAN2.0-only / CAN2.0/CANFD / CANFD-only CAN 
controllers.

E.g. when I set "ip link set can0 up type can bitrate 1000000" on a PEAK PCAN 
USB FD adapter it acts like a CAN2.0 adapter and I can send and receive CAN2.0 
frames.

When a user wants to setup CAN2.0 communication with the RCar CAN FD 
controller he has to provide a second bitrate but not necessarily 'fd on' 
(which is inconsistent).

Assume the user wants to have a simple CAN2.0 setup with the RCar CAN FD.
The steps would be

1. ip link set can0 up type can bitrate 1000000
2. Use the CAN_RAW socket without (== default) CAN_RAW_FD_FRAMES sockopt

At least this looks more elegant and fulfills the user needs and functionality 
than providing an extra 'fd on' or an extra bitrate.

The only difference 'under the hood' would be that the RCar CAN FD controller 
would accept CAN FD frames - that are not visible on this CAN_RAW socket.

IMO we would get much less problems and user disorientation when you copy the 
bitrate into the unset data bitrate registers.

Making everything 'really correct' would mean that the user must set 'fd on' 
every time and we would need to check whether the static ctrlmode bits are 
always set by the user.

@Marc: Do you have an opinion on the user experience here?

Best regards,
Oliver
