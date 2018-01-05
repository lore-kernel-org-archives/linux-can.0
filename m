From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Signal Driven SocketCAN Questions
Date: Fri, 5 Jan 2018 11:20:07 +0100
Message-ID: <20180105102007.GG8058@airbook.vandijck-laurijssen.be>
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
 <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de>
 <20180104112309.GC18339@airbook.vandijck-laurijssen.be>
 <CAM=RW1LM9qYA6EvAwbN0A1x5+MUJ0Hjspe3b0aovoUcEcGFoYA@mail.gmail.com>
 <CAM=RW1LtyFtR0dQz9BYimi6k1uoDJgFEykG6Z7UO3NkUDxgi1A@mail.gmail.com>
 <20180104210856.GA8058@airbook.vandijck-laurijssen.be>
 <CAM=RW1JQxAAKk9-M+h5s-8RMFO5JQJ9hpTqMjuVDcrP656QrEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:44692 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeAEKUL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Jan 2018 05:20:11 -0500
Content-Disposition: inline
In-Reply-To: <CAM=RW1JQxAAKk9-M+h5s-8RMFO5JQJ9hpTqMjuVDcrP656QrEg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

> 
> Thank you guys! I don't why but today morning it is
> working without error for at least an hour. And also
> I am running my application alongside two candump,
> one executing normally and the other with taskset.
> 
> It is crazy. I will try again the signal driven in my
> application and force the ros node to be executed on
> single core to see if it is happening again. I will keep
> in mind that multicore usage may cause problem.

Great.
If I understand well, you run now with only 1 core active.
I'd propose to try Olivers suggestion too, so to allow you to utilize
the other cores for other tasks, and restricting only the reception of
CAN messages to 1 core.

Kurt
