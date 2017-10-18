From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH 2/2] can: usb: esd_usb2: Fix can_dlc value for received
 RTR, frames
Date: Wed, 18 Oct 2017 16:45:24 +0200
Message-ID: <c8a381af-e6ab-cb0c-6a7d-248ab3a9a866@esd.eu>
References: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
 <f6139d9d-47a3-ab10-fe36-27dcff7ef54a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp01.htp-tel.de ([212.59.41.8]:51986 "EHLO mxpout01.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbdJROpf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 18 Oct 2017 10:45:35 -0400
In-Reply-To: <f6139d9d-47a3-ab10-fe36-27dcff7ef54a@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

Am 18.10.2017 um 13:49 schrieb Marc Kleine-Budde:
> On 10/18/2017 01:25 PM, Stefan Mätje wrote:
>> The dlc member of the struct rx_msg contains also the ESD_RTR flag to mark
>> received RTR frames. Without the fix the can_dlc value for received RTR
>> frames would always be set to 8 by get_can_dlc() instead of the received
>> value.
>>
>> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
>> ---
>>  drivers/net/can/usb/esd_usb2.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
>> index 6183b7707ad7..20f2aa21677f 100644
>> --- a/drivers/net/can/usb/esd_usb2.c
>> +++ b/drivers/net/can/usb/esd_usb2.c
>> @@ -49,7 +49,7 @@ MODULE_LICENSE("GPL v2");
>>  #define CMD_IDADD              6 /* also used for IDADD_REPLY */
>>
>>  /* esd CAN message flags - dlc field */
>> -#define ESD_RTR                        0x10
>> +#define ESD_RTR                        0x10u
> 
> I think this is not needed, is it?

Yes, that's not really needed. It's a glitch of my personal style to use
unsigned declarations for values used as masks. I'll change the patch
and send it again.

>>
>>  /* esd CAN message flags - id field */
>>  #define ESD_EXTID              0x20000000
>> @@ -334,7 +334,7 @@ static void esd_usb2_rx_can_msg(struct
>> esd_usb2_net_priv *priv,
>>                 }
>>
>>                 cf->can_id = id & ESD_IDMASK;
>> -               cf->can_dlc = get_can_dlc(msg->msg.rx.dlc);
>> +               cf->can_dlc = get_can_dlc(msg->msg.rx.dlc & ~ESD_RTR);
>>
>>                 if (id & ESD_EXTID)
>>                         cf->can_id |= CAN_EFF_FLAG;
>>
> 
> Marc

Stefan
