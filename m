From: "Aiken, Scott" <Scott.Aiken@karlstorz.com>
Subject: RE: can acknowledgment
Date: Wed, 4 Sep 2013 20:52:37 +0000
Message-ID: <11071630B606A2488DE633430B530FDE57F0714E@ELS-EX01-PV.KSTG.corp>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
 <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx0.karlstorz.com ([62.134.46.134]:27087 "EHLO
	mx0.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760745Ab3IDUw5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2013 16:52:57 -0400
In-Reply-To: <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hmm, you can't ack or send.  Is your CAN_TX pin correctly wired to the port?

-----Original Message-----
From: Michael Muldoon [mailto:mbmuldoon07@gmail.com] 
Sent: Wednesday, September 04, 2013 1:41 PM
To: Aiken, Scott
Cc: linux-can@vger.kernel.org
Subject: Re: can acknowledgment

Thanks for responding.  The bitrate is definitely right if I send the candump command I can see the traffic being sent by the other two devices on the network. The problem is if I take either of the other two devices off the network candump sees nothing and at not point does cansend ever work.

On Wed, Sep 4, 2013 at 4:19 PM, Aiken, Scott <Scott.Aiken@karlstorz.com> wrote:
> Did you set the right bit rate for your network?
> Do you have a bus analyzer to see if your target is trying to transmit?
>
> This may tell you why your target isn't happy:
>     int errFilter = CAN_ERR_TX_TIMEOUT |
>              CAN_ERR_LOSTARB | CAN_ERR_CRTL |
>              CAN_ERR_PROT | CAN_ERR_TRX | CAN_ERR_ACK |
>              CAN_ERR_BUSOFF | CAN_ERR_BUSERROR |
>              CAN_ERR_RESTARTED; /* see linux/can/error.h */
>     setsockopt( s, SOL_CAN_RAW, &errFilter, sizeof(errFilter) );
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
> So I have a decent amount of experience with can but this is my first time using it on a linux device and therefore my first experience with socket-can.  Anyway the problem is that I am unable to view any can messages on the network without two other can devices on it currently a pcan from preak systems and an intrepid fire.  Also I'm unable to send can messages.  Everything seems to be pointing to a can acknowledgment issue which I have had experience with before but I can't seems to figure out the root cause of it here.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
