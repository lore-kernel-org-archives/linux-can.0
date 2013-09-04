From: "Aiken, Scott" <Scott.Aiken@karlstorz.com>
Subject: RE: can acknowledgment
Date: Wed, 4 Sep 2013 21:15:40 +0000
Message-ID: <11071630B606A2488DE633430B530FDE57F07191@ELS-EX01-PV.KSTG.corp>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
	<CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F0714E@ELS-EX01-PV.KSTG.corp>
 <CAJU5jUKBdqRjZrxJ7P149_c_6n=JbtxvfBxr_Fh+WH4w5gxXag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.karlstorz.com ([62.134.46.135]:11474 "EHLO
	mx1.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab3IDVPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2013 17:15:44 -0400
In-Reply-To: <CAJU5jUKBdqRjZrxJ7P149_c_6n=JbtxvfBxr_Fh+WH4w5gxXag@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

To ack, the device has to pull the CAN_TX pin low.  If the device's CAN=
_TX isn't actually connected to the bus for whatever reason (short, bre=
ak, etc.), then it can't send or ack.  All it can do is listen to packe=
ts that are ack'ed by other nodes.

-----Original Message-----
=46rom: Michael Muldoon [mailto:mbmuldoon07@gmail.com]=20
Sent: Wednesday, September 04, 2013 2:05 PM
To: Aiken, Scott
Cc: linux-can@vger.kernel.org
Subject: RE: can acknowledgment

What do you mean by the CAN_TX pin? The can hi and lo are fine if eithe=
r were messed up nothing would work.=20
On Sep 4, 2013 4:52 PM, "Aiken, Scott" <Scott.Aiken@karlstorz.com> wrot=
e:
Hmm, you can't ack or send. =A0Is your CAN_TX pin correctly wired to th=
e port?

-----Original Message-----
=46rom: Michael Muldoon [mailto:mbmuldoon07@gmail.com]
Sent: Wednesday, September 04, 2013 1:41 PM
To: Aiken, Scott
Cc: linux-can@vger.kernel.org
Subject: Re: can acknowledgment

Thanks for responding. =A0The bitrate is definitely right if I send the=
 candump command I can see the traffic being sent by the other two devi=
ces on the network. The problem is if I take either of the other two de=
vices off the network candump sees nothing and at not point does cansen=
d ever work.

On Wed, Sep 4, 2013 at 4:19 PM, Aiken, Scott <Scott.Aiken@karlstorz.com=
> wrote:
> Did you set the right bit rate for your network?
> Do you have a bus analyzer to see if your target is trying to transmi=
t?
>
> This may tell you why your target isn't happy:
> =A0 =A0 int errFilter =3D CAN_ERR_TX_TIMEOUT |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0CAN_ERR_LOSTARB | CAN_ERR_CRTL |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0CAN_ERR_PROT | CAN_ERR_TRX | CAN_ERR_ACK |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0CAN_ERR_BUSOFF | CAN_ERR_BUSERROR |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0CAN_ERR_RESTARTED; /* see linux/can/error.=
h */
> =A0 =A0 setsockopt( s, SOL_CAN_RAW, &errFilter, sizeof(errFilter) );
>
> And watch for error messages...
>
>
> -----Original Message-----
> From: linux-can-owner@vger.kernel.org
> [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Michael Muldoon
> Sent: Wednesday, September 04, 2013 12:48 PM
> To: linux-can@vger.kernel.org
> Subject: can acknowledgment
>
> So I have a decent amount of experience with can but this is my first=
 time using it on a linux device and therefore my first experience with=
 socket-can. =A0Anyway the problem is that I am unable to view any can =
messages on the network without two other can devices on it currently a=
 pcan from preak systems and an intrepid fire. =A0Also I'm unable to se=
nd can messages. =A0Everything seems to be pointing to a can acknowledg=
ment issue which I have had experience with before but I can't seems to=
 figure out the root cause of it here.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at =A0http://vger.kernel.org/majordomo-info.html
