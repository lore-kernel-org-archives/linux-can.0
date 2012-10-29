From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] candump: add option to ignore ENOBUFS
Date: Mon, 29 Oct 2012 09:00:11 +0100
Message-ID: <CAGm1_kvSeE3ge9SJB7Vb=J1e8qR_92aAAkRghe88M-_ErBEEBg@mail.gmail.com>
References: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com>
 <508A5C05.6050803@pengutronix.de> <508D8F53.1050005@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:32851 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab2J2IAd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 04:00:33 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1581562eaa.19
        for <linux-can@vger.kernel.org>; Mon, 29 Oct 2012 01:00:32 -0700 (PDT)
In-Reply-To: <508D8F53.1050005@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Sun, Oct 28, 2012 at 9:02 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 26.10.2012 11:46, Marc Kleine-Budde wrote:
>
>> On 10/26/2012 11:42 AM, yegorslists@googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> -f option replicated -i option from cangen and allows to
>>> ignore ENOBUFS error in bridge mode
>>
>> Better not ignore, but handle the error. If socket would support, wait
>> with select/poll that the socket get writable and try again. For now
>> sleep and try again. (or fix the poll/select bug in the kernel).
>
>
> ACK.
>
> IIRC this was a problem of socket write queue length that are too long to
> handle short MTUs like we have with CAN frames.
> Therefore the socket itself does not stop the traffic.
>
> Definitely something to be fixed ... i'll take a look into the mails from
> Michal Sojka.

Thanks. So the whole changes then would be related to all can-utils,
that can send data (candump, cangen etc.)?

Yegor
