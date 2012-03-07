From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 15:05:48 +0100
Message-ID: <4F576B3C.7000607@peak-system.com>
References: <20120306112108.GA4362@elgon.mountain>
 <20120307122112.GC674@mwanda> <4F57549F.3050309@pengutronix.de>
 <20120307131741.GD674@mwanda> <4F5761F2.5010301@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:50540 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611Ab2CGOF4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 09:05:56 -0500
In-Reply-To: <4F5761F2.5010301@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-can@vger.kernel.org



Le 07/03/2012 14:26, Marc Kleine-Budde a =E9crit :
> On 03/07/2012 02:17 PM, Dan Carpenter wrote:
>> On Wed, Mar 07, 2012 at 01:29:19PM +0100, Marc Kleine-Budde wrote:
>>> On 03/07/2012 01:21 PM, Dan Carpenter wrote:
>>>> On Tue, Mar 06, 2012 at 02:21:08PM +0300, Dan Carpenter wrote:
>>>>> Hello Stephane Grosjean,
>>>>>
>>>>> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB
>>>>> specific part" from Mar 2, 2012, leads to the following warning:
>>>>>
>>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
>>>>> 	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>>>>>
>>>>> drivers/net/can/usb/peak_usb/pcan_usb.c
>>>>>     742          /* can id */
>>>>>     743          if (cf->can_id&  CAN_EFF_FLAG) {
>>>>>     744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id&=
  CAN_ERR_MASK);
>>>>>     745
>>>>>     746                  tmp32<<=3D 3;
>>>> Also we can't be doing this shift on little endian data.
>>> This should be first shift, then convert to little endian, isn't it=
?
>>>
>> That's my guess too.
>> 		__le32 tmp32 =3D cpu_to_le32((cf->can_id&  CAN_ERR_MASK)<<  3);
> St=E9phane, do you want to make that patch?
> Add my Acked-by and a
> "Reported-by: Dan Carpenter<dan.carpenter@oracle.com>"

Ok I'll do it as soon as I did small tests to check.

=46YI, the patch will also contain the same fix but for the tmp16 local=
,=20
declared into the "else" block:

     __le16 tmp16 =3D cpu_to_le16((cf->can_id & CAN_ERR_MASK) << 5);


Regards,

St=E9phane


--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
