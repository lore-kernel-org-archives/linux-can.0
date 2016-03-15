From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Tue, 15 Mar 2016 20:38:20 +0100
Message-ID: <56E864AC.2040605@hartkopp.net>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:23327 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcCOTio (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Mar 2016 15:38:44 -0400
In-Reply-To: <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Ramesh,

On 03/15/2016 03:17 PM, Ramesh Shanmugasundaram wrote:

>> On 03/15/2016 10:48 AM, Ramesh Shanmugasundaram wrote:
>>
>>> +config CAN_RCAR_CANFD
>>> +	tristate "Renesas R-Car CAN FD controller"
>>> +	depends on ARCH_RENESAS || ARM
>>> +	---help---
>>> +	  Say Y here if you want to use CAN FD controller found on
>>> +	  Renesas R-Car SoCs.
>>> +
>>> +	  To compile this driver as a module, choose M here: the module will
>>> +	  be called rcar_canfd.
>>
>> Would it make sense to add some more documentation here that this
>> controller is a CANFD-only CAN controller which (of course) can cope with
>> CAN2.0B frames but has no dedicated CAN2.0B mode?
>
> OK. I'll modify it as
>
> "Say Y here if you want to use CAN FD controller found on
> Renesas R-Car SoCs. The driver puts the controller in CANFD-only mode,
> which can interoperate with CAN2.0 nodes but does not support
> dedicated CAN 2.0 mode"
>
> Sounds OK?

Yep :-)

>
>>
>> (..)
>>
>>> +static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv,
>>> +u32 ch) {
>>
>> (..)
>>
>>> +
>>> +	priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
>>> +	priv->can.data_bittiming_const =
>>> +		&rcar_canfd_data_bittiming_const;
>>> +
>>> +	/* Controller starts in CAN FD only mode. In this mode, to
>> interoperate
>>> +	 * with classical CAN only nodes, data bitrate should be configured
>> the
>>> +	 * same as nominal bitrate.
>>> +	 */
>>
>> 'Should' sounds like a pretty soft requirement here - and this info should
>> not hide deep in the code IMO.
>
> OK. I'll add a comment at the start of the driver like
> ---
> "The driver puts the controller in CAN FD only mode. In this mode, the controller acts as a CAN FD node that can also interoperate with CAN 2.0 nodes. The driver does not support dedicated CAN 2.0 only mode at present.
>
> When configuring the controller to interoperate with CAN 2.0 nodes only, the data bitrate MUST be configured the same as nominal bitrate.
>
> e.g. ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
> ---
>
> Will this be OK?

See comment below.

>
>>
>> What happens if the user only defines:
>>
>> 	"ip link set can0 up type can bitrate 1000000"
>>
>> instead of
>>
>> 	"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
>>
>> ??
>
> This is not possible isn't it? netlink already does a sanity check on dbitrate before bring up of a FD node.

No. It's not netlink but the open_candev() function which does the 
sanity check - the function you call in rcar_canfd_open():

 > +
 > +static int rcar_canfd_open(struct net_device *ndev)
 > +{
 > +	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 > +	struct rcar_canfd_global *gpriv = priv->gpriv;
 > +	int err;
 > +
 > +	/* Peripheral clock is already enabled in probe */
 > +	err = clk_prepare_enable(gpriv->can_clk);
 > +	if (err) {
 > +		netdev_err(ndev, "failed to enable CAN clock, error %d\n", err);
 > +		goto out_clock;
 > +	}

I wonder if it makes sense to add

if (!priv->data_bittiming.bitrate) {

	/* copy arbitration bitrate to data bitrate registers */

}

here instead of urging the user to provide an identical data bitrate to 
configure a working CAN2.0 setup.

 > +
 > + err = open_candev(ndev);
 > + if (err) {
 > + netdev_err(ndev, "open_candev() failed, error %d\n", err);
 > + goto out_can_clock;
 > + }
 > +

As we omitted to force the user to provide 'fd on' at configuration time 
- why should we force users to provide a second bitrate for a CAN2.0 
operation??

This looks more straight forward to me and hides the fact of handling a 
CANFD-only controller differently to a CAN2.0 or CAN2.0/CANFD controller 
setup.

>
>>
>> Would it make sense to set the data bitrate according to the arbitration
>> bitrate in rcar_canfd_set_bittiming() or sanitize this at some other place
>> when not data bitrate is given by the netlink command?
>
> This is not required in my opinion. For e.g.
>
> 1) ip link set can0 up type can bitrate 1000000
> - This is not possible as mentioned above
>
> 2) ip link set can0 up type can bitrate 1000000 dbitrate 500000
> - Again netlink sanity checks will fail.
>
> 3) ip link set can0 up type can bitrate 500000 dbitrate 1000000
> - If the user's intention is to configure CAN 2.0, they would not try this (i.e.) providing a dbitrate
> - Of course, this will be accepted as a valid FD configuration
>
> 4) ip link set can0 up type can bitrate 1000000 dbitrate 2000000
> ip link set can0 down
> ip link set can0 up type can bitrate 500000
> - This is accepted and valid. This means the nom & data bitrates are 500000 & 2000000 respectively and still in FD mode. This kind of config is true for any "net" device.
>
> Conclusion is, if the user's intention is to configure CAN 2.0 node they would not provide data bitrate

Exactly this single bitrate configuration is not possible right now ... 
or did I miss anything?

Best regards,
Oliver


> and if they do, it has to be same as nominal. Otherwise it becomes a valid FD configuration. In all these configs - mode, mtu & bitrates are consistent.
>
> Thanks,
> Ramesh
>
