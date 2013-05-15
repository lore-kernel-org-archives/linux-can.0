From: kedari appana <kedare06@gmail.com>
Subject: Re: CANutilities
Date: Wed, 15 May 2013 14:22:40 +0530
Message-ID: <CANdmM3NqyKWPxrN0xZyvFzGo9trPO5ZPMtSvSMjfQf2vDcioLQ@mail.gmail.com>
References: <CANdmM3MkAN9tZLUDSnVrdXTngu7CH5UESUAo7NO4u85D0Hg2tQ@mail.gmail.com>
	<5193360F.3040609@pengutronix.de>
	<CANdmM3Mo0q7OpX5-ScnLhtWGEiPBvgeKx9SPe=+KBeABodP46g@mail.gmail.com>
	<51933C8A.1040404@pengutronix.de>
	<CANdmM3OizYxY3dhUN=h2+TGmTa3D31fuXNLb5Mw9S3Lts_cpkw@mail.gmail.com>
	<51934649.2000103@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56902 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab3EOIwn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 04:52:43 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so1823482oag.20
        for <linux-can@vger.kernel.org>; Wed, 15 May 2013 01:52:42 -0700 (PDT)
In-Reply-To: <51934649.2000103@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

hi Marc,

if i try without triple sampling on
and just this command #./canconfig can0 bitrate 100000 ctrlmode  loopback on

1c
can0 bitrate: 100000, sample-point: 0.875
RTNETLINK answers: Operation not supported
can0: failed to set ctrlmode
the same error i am getting what was the issue.

Regards,
Kedar.

On Wed, May 15, 2013 at 1:54 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 05/15/2013 10:21 AM, kedari appana wrote:
>> xilinx canps
>
> If your hardware doesn't support triple sampling, why are you trying to
> active it?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
