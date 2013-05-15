From: kedari appana <kedare06@gmail.com>
Subject: Re: CANutilities
Date: Wed, 15 May 2013 14:29:02 +0530
Message-ID: <CANdmM3NoW9wu-FD3dm=U0X+KO3LcLsqVWaxCRPf3LmY_uGFdRQ@mail.gmail.com>
References: <CANdmM3MkAN9tZLUDSnVrdXTngu7CH5UESUAo7NO4u85D0Hg2tQ@mail.gmail.com>
	<5193360F.3040609@pengutronix.de>
	<CANdmM3Mo0q7OpX5-ScnLhtWGEiPBvgeKx9SPe=+KBeABodP46g@mail.gmail.com>
	<51933C8A.1040404@pengutronix.de>
	<CANdmM3OizYxY3dhUN=h2+TGmTa3D31fuXNLb5Mw9S3Lts_cpkw@mail.gmail.com>
	<51934649.2000103@pengutronix.de>
	<CANdmM3NqyKWPxrN0xZyvFzGo9trPO5ZPMtSvSMjfQf2vDcioLQ@mail.gmail.com>
	<51934DFF.40700@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40488 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758473Ab3EOI7D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 04:59:03 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so1688453obb.16
        for <linux-can@vger.kernel.org>; Wed, 15 May 2013 01:59:02 -0700 (PDT)
In-Reply-To: <51934DFF.40700@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

yes

On Wed, May 15, 2013 at 2:27 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 05/15/2013 10:52 AM, kedari appana wrote:
>> if i try without triple sampling on
>> and just this command #./canconfig can0 bitrate 100000 ctrlmode  loopback on
>>
>> 1c
>> can0 bitrate: 100000, sample-point: 0.875
>> RTNETLINK answers: Operation not supported
>> can0: failed to set ctrlmode
>> the same error i am getting what was the issue.
>
> Does your hardware/driver support loopback mode?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
