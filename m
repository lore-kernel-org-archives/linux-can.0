From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Signal Driven SocketCAN Questions
Date: Thu, 4 Jan 2018 12:23:09 +0100
Message-ID: <20180104112309.GC18339@airbook.vandijck-laurijssen.be>
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
 <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:52212 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeADLfo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 06:35:44 -0500
Content-Disposition: inline
In-Reply-To: <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

> On 01/04/2018 10:48 AM, Yousof Ebneddin Hamidi wrote:
> > I am trying to write a Signal Driven SocketCan with ROS in Ubuntu.
> > I have two problems:
> 
> Uhh, better not use signals in Linux, better wait with a
> select/poll/epoll or use an abstraction library like libevent, libev or
> libuv.
> 
> > 1- I do not get a signal for each arrival message. Or maybe the
> > process of the signal takes too much time that I miss some signals
> 

This is very normal. Signal delivery is not a queue, but a mask.
If you send the same signal twice to a process, before the first is handled,
then you only receive 1.

see also http://man7.org/linux/man-pages/man7/signal.7.html, in the paragraph
on real-time signal, item '1. Multiple instances ...'

I do not advise against signals in general, but I
do agree that you were using them in a wrong way, and marc's advice stands.

> ok
> 
> > 2- To solve the above problem I am reading the buffer until it is
> > empty at each SIGIO. Therefore I guarantee that I read all the CAN
> > messages and their timestamp.

That is a correct use of SIGIO.

> > The new problem emerges now.

The most common problem using signals is asynchronous execution of code.
Do you have in the SIGIO signal handler more code than just setting a
flag?

see also http://man7.org/linux/man-pages/man7/signal-safety.7.html

Kurt
