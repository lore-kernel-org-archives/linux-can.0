From: Yousof Ebneddin Hamidi <youebned@gmail.com>
Subject: Re: Signal Driven SocketCAN Questions
Date: Fri, 5 Jan 2018 10:46:05 +0100
Message-ID: <CAM=RW1JQxAAKk9-M+h5s-8RMFO5JQJ9hpTqMjuVDcrP656QrEg@mail.gmail.com>
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
 <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de> <20180104112309.GC18339@airbook.vandijck-laurijssen.be>
 <CAM=RW1LM9qYA6EvAwbN0A1x5+MUJ0Hjspe3b0aovoUcEcGFoYA@mail.gmail.com>
 <CAM=RW1LtyFtR0dQz9BYimi6k1uoDJgFEykG6Z7UO3NkUDxgi1A@mail.gmail.com> <20180104210856.GA8058@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43794 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeAEJqI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Jan 2018 04:46:08 -0500
Received: by mail-lf0-f65.google.com with SMTP id o26so4537982lfc.10
        for <linux-can@vger.kernel.org>; Fri, 05 Jan 2018 01:46:07 -0800 (PST)
In-Reply-To: <20180104210856.GA8058@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

Thank you guys! I don't why but today morning it is
working without error for at least an hour. And also
I am running my application alongside two candump,
one executing normally and the other with taskset.

It is crazy. I will try again the signal driven in my
application and force the ros node to be executed on
single core to see if it is happening again. I will keep
in mind that multicore usage may cause problem.

Another question where can I get an archive of this
mailing list in case of another problem, I could search
first there? I could not find any archive. I have
joined this mailing list recently.

On 4 January 2018 at 22:08, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
>> Hi again,
>> I changed the candump as following
>> https://github.com/yosoufe/can-utils/commit/51e542621da1128ebdf219b78c609b83c03df007
>> shorter link:
>> https://goo.gl/eqwYJB
>>
>> In the time difference it was written that if the sec is
>> negative, make it zero. I commented that out and said
>> if is is negative, first print the difference and also the
>> current and previous timestamp and then running = 0
>> (or stop).
>>
>> then Execute:
>> ./candump can0 -td -c
>>
>> Still in this case which I am only running candump
>> and no other CAN software, After about 2-3 minutes
>> I am getting a CAN message which is in wrong order
>>
>> https://i.imgur.com/YR76mQ1.png
>>
>> what can be wrong now? is it the peakCAN driver?
>> Kernel Problem? canDump problem? my PC problem?
>
> My best guess is a multicore issue.
> Can you disable cpu cores and test with a single core?
>
> Kurt
>
>>
>> regards,
>> Yousof
>>
>> On 4 January 2018 at 12:33, Yousof Ebneddin Hamidi <youebned@gmail.com> wrote:
>> > On 4 January 2018 at 12:23, Kurt Van Dijck
>> > <dev.kurt@vandijck-laurijssen.be> wrote:
>> >>> On 01/04/2018 10:48 AM, Yousof Ebneddin Hamidi wrote:
>> >
>> >> The most common problem using signals is asynchronous execution of code.
>> >> Do you have in the SIGIO signal handler more code than just setting a
>> >> flag?
>> >>
>> >> see also http://man7.org/linux/man-pages/man7/signal-safety.7.html
>> >
>> > Yes! I am doing more. I am publishing the CAN messages in ROS. Thanks.
>> > Useful links.
>> >
>> > But still I saw the same problem in candump as well but much less frequent.
>> > I wrote in previous email. In the following image the last message has smaller
>> > timestamp than previous. The image is the output of the candump. My
>> > application was also running in parallel.
>> >
>> > https://i.imgur.com/kVH24gC.png
>> >
>> > regards, and thank you all
>> > Yousof
