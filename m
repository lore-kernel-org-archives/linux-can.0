From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: Retrieve amount of queued frames in the txqueue of a interface
Date: Thu, 7 Feb 2013 17:18:33 +0100
Message-ID: <CAJsOQGMbTkJfc8YYiTdhc9r3aT1mD9MfGmWL3u=DwOmPojNLiw@mail.gmail.com>
References: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com>
	<5113851F.1060501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:44405 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3BGQSe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 11:18:34 -0500
Received: by mail-qc0-f182.google.com with SMTP id k19so1035531qcs.41
        for <linux-can@vger.kernel.org>; Thu, 07 Feb 2013 08:18:33 -0800 (PST)
In-Reply-To: <5113851F.1060501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

On Thu, Feb 7, 2013 at 11:42 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/06/2013 12:59 PM, Felix Obenhuber wrote:
>> Hi,
>>
>> how can I retrive the number of frames currently queued for
>> transmission on a SocketCAN interface? Is this possible via netlink?
>
> Sorry, I don't know. What's you usecase?

We're working with ISOBUS systems (ISO11783). During a transport
protocol session (similiar to iso tp) we'd like to know how many
frames can get queued at once to adjust timings. There are multiple
software modules that might send frames at the same time over  a
single module/socket.

Maybe we have to add a tx fifo within the software...

cheers,

Felix
