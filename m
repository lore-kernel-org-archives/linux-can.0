From: kedari appana <kedare06@gmail.com>
Subject: Re: CANutilities
Date: Wed, 15 May 2013 14:30:12 +0530
Message-ID: <CANdmM3MfWN6ZHyBQzUUje0i0xFhaVVJ8hFLUzCvgGyzyyEkH3Q@mail.gmail.com>
References: <CANdmM3MkAN9tZLUDSnVrdXTngu7CH5UESUAo7NO4u85D0Hg2tQ@mail.gmail.com>
	<5193360F.3040609@pengutronix.de>
	<CANdmM3Mo0q7OpX5-ScnLhtWGEiPBvgeKx9SPe=+KBeABodP46g@mail.gmail.com>
	<51933C8A.1040404@pengutronix.de>
	<CANdmM3OizYxY3dhUN=h2+TGmTa3D31fuXNLb5Mw9S3Lts_cpkw@mail.gmail.com>
	<51934649.2000103@pengutronix.de>
	<CANdmM3NqyKWPxrN0xZyvFzGo9trPO5ZPMtSvSMjfQf2vDcioLQ@mail.gmail.com>
	<51934DFF.40700@pengutronix.de>
	<CANdmM3NoW9wu-FD3dm=U0X+KO3LcLsqVWaxCRPf3LmY_uGFdRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:41750 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757289Ab3EOJAN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 05:00:13 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so1865716oag.15
        for <linux-can@vger.kernel.org>; Wed, 15 May 2013 02:00:12 -0700 (PDT)
In-Reply-To: <CANdmM3NoW9wu-FD3dm=U0X+KO3LcLsqVWaxCRPf3LmY_uGFdRQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

yes it supports loopback mode and silent mode.I tried with the ip
command and as well as with the canconfig command same error as
mentioned above i am getting

On Wed, May 15, 2013 at 2:29 PM, kedari appana <kedare06@gmail.com> wrote:
> yes
>
> On Wed, May 15, 2013 at 2:27 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 05/15/2013 10:52 AM, kedari appana wrote:
>>> if i try without triple sampling on
>>> and just this command #./canconfig can0 bitrate 100000 ctrlmode  loopback on
>>>
>>> 1c
>>> can0 bitrate: 100000, sample-point: 0.875
>>> RTNETLINK answers: Operation not supported
>>> can0: failed to set ctrlmode
>>> the same error i am getting what was the issue.
>>
>> Does your hardware/driver support loopback mode?
>>
>> Marc
>>
>> --
>> Pengutronix e.K.                  | Marc Kleine-Budde           |
>> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>>
