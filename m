From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Signal Driven SocketCAN Questions
Date: Thu, 4 Jan 2018 21:42:45 +0100
Message-ID: <7e8a4008-c2af-a506-4cb4-ef144f32e6e4@hartkopp.net>
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
 <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de>
 <20180104112309.GC18339@airbook.vandijck-laurijssen.be>
 <CAM=RW1LM9qYA6EvAwbN0A1x5+MUJ0Hjspe3b0aovoUcEcGFoYA@mail.gmail.com>
 <CAM=RW1LtyFtR0dQz9BYimi6k1uoDJgFEykG6Z7UO3NkUDxgi1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:11755 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeADUm5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 15:42:57 -0500
In-Reply-To: <CAM=RW1LtyFtR0dQz9BYimi6k1uoDJgFEykG6Z7UO3NkUDxgi1A@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>, dev.kurt@vandijck-laurijssen.be

Hi Yousof,

we have some CAN drivers that support NAPI for netdevices and some other 
CAN drivers (e.g. the CAN USB drivers) that do not use NAPI.

You can try to use the SMP-affinity to pin the interrupt to a specific 
CPU with https://www.kernel.org/doc/Documentation/IRQ-affinity.txt

The problem can show up in multi core processors as the interrupt may be 
handled by different cores - which finally can lead to a wrong order in 
packet processing.

Can you check if the SMP affinity workaround fixes your problem?

Regards,
Oliver

On 01/04/2018 05:01 PM, Yousof Ebneddin Hamidi wrote:
> Hi again,
> I changed the candump as following
> https://github.com/yosoufe/can-utils/commit/51e542621da1128ebdf219b78c609b83c03df007
> shorter link:
> https://goo.gl/eqwYJB
> 
> In the time difference it was written that if the sec is
> negative, make it zero. I commented that out and said
> if is is negative, first print the difference and also the
> current and previous timestamp and then running = 0
> (or stop).
> 
> then Execute:
> ./candump can0 -td -c
> 
> Still in this case which I am only running candump
> and no other CAN software, After about 2-3 minutes
> I am getting a CAN message which is in wrong order
> 
> https://i.imgur.com/YR76mQ1.png
> 
> what can be wrong now? is it the peakCAN driver?
> Kernel Problem? canDump problem? my PC problem?
> 
> regards,
> Yousof
> 
> On 4 January 2018 at 12:33, Yousof Ebneddin Hamidi <youebned@gmail.com> wrote:
>> On 4 January 2018 at 12:23, Kurt Van Dijck
>> <dev.kurt@vandijck-laurijssen.be> wrote:
>>>> On 01/04/2018 10:48 AM, Yousof Ebneddin Hamidi wrote:
>>
>>> The most common problem using signals is asynchronous execution of code.
>>> Do you have in the SIGIO signal handler more code than just setting a
>>> flag?
>>>
>>> see also http://man7.org/linux/man-pages/man7/signal-safety.7.html
>>
>> Yes! I am doing more. I am publishing the CAN messages in ROS. Thanks.
>> Useful links.
>>
>> But still I saw the same problem in candump as well but much less frequent.
>> I wrote in previous email. In the following image the last message has smaller
>> timestamp than previous. The image is the output of the candump. My
>> application was also running in parallel.
>>
>> https://i.imgur.com/kVH24gC.png
>>
>> regards, and thank you all
>> Yousof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
