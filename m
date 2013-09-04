From: Michael Muldoon <mbmuldoon07@gmail.com>
Subject: Re: can acknowledgment
Date: Wed, 4 Sep 2013 16:40:37 -0400
Message-ID: <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49003 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3IDUki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2013 16:40:38 -0400
Received: by mail-wg0-f41.google.com with SMTP id a12so3083117wgh.4
        for <linux-can@vger.kernel.org>; Wed, 04 Sep 2013 13:40:37 -0700 (PDT)
In-Reply-To: <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Aiken, Scott" <Scott.Aiken@karlstorz.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Thanks for responding.  The bitrate is definitely right if I send the
candump command I can see the traffic being sent by the other two
devices on the network. The problem is if I take either of the other
two devices off the network candump sees nothing and at not point does
cansend ever work.

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
> From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Michael Muldoon
> Sent: Wednesday, September 04, 2013 12:48 PM
> To: linux-can@vger.kernel.org
> Subject: can acknowledgment
>
> So I have a decent amount of experience with can but this is my first time using it on a linux device and therefore my first experience with socket-can.  Anyway the problem is that I am unable to view any can messages on the network without two other can devices on it currently a pcan from preak systems and an intrepid fire.  Also I'm unable to send can messages.  Everything seems to be pointing to a can acknowledgment issue which I have had experience with before but I can't seems to figure out the root cause of it here.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
