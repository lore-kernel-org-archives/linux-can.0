From: Yousof Ebneddin Hamidi <youebned@gmail.com>
Subject: Re: Signal Driven SocketCAN Questions
Date: Thu, 4 Jan 2018 12:33:45 +0100
Message-ID: <CAM=RW1LM9qYA6EvAwbN0A1x5+MUJ0Hjspe3b0aovoUcEcGFoYA@mail.gmail.com>
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
 <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de> <20180104112309.GC18339@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:41721 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeADLdr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 06:33:47 -0500
Received: by mail-lf0-f53.google.com with SMTP id h137so1436337lfe.8
        for <linux-can@vger.kernel.org>; Thu, 04 Jan 2018 03:33:47 -0800 (PST)
In-Reply-To: <20180104112309.GC18339@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On 4 January 2018 at 12:23, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>> On 01/04/2018 10:48 AM, Yousof Ebneddin Hamidi wrote:

> The most common problem using signals is asynchronous execution of code.
> Do you have in the SIGIO signal handler more code than just setting a
> flag?
>
> see also http://man7.org/linux/man-pages/man7/signal-safety.7.html

Yes! I am doing more. I am publishing the CAN messages in ROS. Thanks.
Useful links.

But still I saw the same problem in candump as well but much less frequent.
I wrote in previous email. In the following image the last message has smaller
timestamp than previous. The image is the output of the candump. My
application was also running in parallel.

https://i.imgur.com/kVH24gC.png

regards, and thank you all
Yousof
