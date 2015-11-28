From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Setting bitrate from user-space application
Date: Sat, 28 Nov 2015 13:28:12 +1100
Message-ID: <5659113C.20000@optusnet.com.au>
References: <5655BF6D.3000701@picquet.fr> <5655CC8D.70508@pengutronix.de>
 <5655DC22.4000302@hartkopp.net> <5655DF32.5090505@picquet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:47079 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091AbbK1C41 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Nov 2015 21:56:27 -0500
In-Reply-To: <5655DF32.5090505@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 26/11/2015 3:17 AM, Guillaume Picquet wrote:
> Le 25/11/2015 17:04, Oliver Hartkopp a =C3=A9crit :
>> Hi Guillaume,
>>
>> On 11/25/2015 03:58 PM, Marc Kleine-Budde wrote:
>>> On 11/25/2015 03:02 PM, Guillaume Picquet wrote:
>>>> Hi all,
>>>>
>>>> I prefer to ask first to those who know.
>>>>
>>>> What is the 'normal' way of setting CAN bitrate from user-space
>>>> application ?

The "abnormal" way I do it is basically:

     char *pName =3D (a_eDevice =3D=3D CAN_BUS_CAN_0) ? "can0" : "can1"=
;
     sprintf(vBuf,
             "/usr/local/sbin/canconfig %s stop > /dev/null ; "
             "/usr/local/sbin/canconfig %s bitrate %d > /dev/null ; "
             "/usr/local/sbin/canconfig %s start > /dev/null\n",
             pName, pName, a_nKbaud * 1000, pName);
             nRc =3D system(vBuf);

Or if using Freescale's 2.6.35 driver, "ifconfig can0 down/up" and
"echo 500000 > /sys/class/devices/platform/FlexCAN.0/bitrate" in the=20
above "system()" call.

I realise the above may be horrible, but I'd like some more information=
=20
on why it might be bad.

Tom

