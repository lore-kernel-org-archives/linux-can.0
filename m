From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Flexcan (was: Re: Fwd: Querying current tx_queue usage of a SocketCAN
 interface)
Date: Fri, 10 Apr 2015 16:35:43 +1000
Message-ID: <55276F3F.7020903@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CA777.8070208@optusnet.com.au> <551CE174.2030303@pengutronix.de> <551D298D.7040809@optusnet.com.au> <551F5B4C.7090900@optusnet.com.au> <552632F7.5090204@optusnet.com.au>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:46596 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755186AbbDJGfq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Apr 2015 02:35:46 -0400
In-Reply-To: <552632F7.5090204@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, dan.egnor@gmail.com, linux-can@vger.kernel.org

On 09/04/15 18:06, Tom Evans wrote:
> On 04/04/15 14:32, Tom Evans wrote:
>> On 2/04/2015 10:35 PM, Tom Evans wrote:
>> ...
>> And schedules NAPI to forward them from there rather than reading them from
>> the hardware FIFO.
>>
>> The purpose of NAPI is to make the interrupts as fast as possible, doing as
>> little work as possible, but servicing time-critical hardware so it doesn't
>> overflow/underflow. Operations like reading characters from a serial port.
>>
>> But that assumes the "little work" is fast. In the case of the FlexCAN driver,
>> it takes about 5 reads and a write to read a CAN message, and there may be six
>> messages in the FIFO.
>>
>> Not many accesses, but peripheral device registers can be notoriously slow on
>> some CPUs [1].
>  > ...
>> I'll try and measure this on Tuesday.
>
> Now quite tomorrow, but I have some results:
>
> [    1.494142] flexcan flexcan.1: One do_gettimeofday took 0 us)
> [    1.499903] flexcan flexcan.1: Ten do_gettimeofday took 4 us)
> [    1.505677] flexcan flexcan.1: 100 flexcan_read() took 23 us)
>
> I first measured the overhead of calling do_gettimeofday(), which is about
> 0.4us. So I can pretty much ignore that in this test.
>
> Then in a loop reading a FlexCAN control register, it took about 0.23us per
> read. That's 230ns or about 184 CPU clocks at 800MHz.
>
> OK, so this IS a slow peripheral.
>
> Given it takes about 5 reads to read one message, that's about 1.15us per
> message. With a queue depth of "6" that's a maximum extra delay of 6.9us.

That would only happen if interrupts were delayed for 6 whole CAN message 
times, which is over 600us. This should be unlikely. In the more common case, 
one interrupt would read one message, meaning only about 1.15us more than 
throwing to NAPI.

Does anyone have any figures on how slow (how many CPU cycles to read and 
write) the other peripherals are on this CPU? This is something I've never 
seen in any Freescale manual for any of their CPUs.

I wonder if any of the other peripherals are faster? I can run that test myself:

[    1.588819] flexcan flexcan.1: 100 read(ssi)     @0x50014000  took 24 us
[    1.596449] flexcan flexcan.1: 100 read(esdhc1)  @0x50004000  took 25 us
[    1.604337] flexcan flexcan.1: 100 read(uart)    @0x5000c000  took 23 us
[    1.612051] flexcan flexcan.1: 100 read(flexcan) @0x53fc8000  took 23 us
[    1.620017] flexcan flexcan.1: 100 read(gpio)    @0x53f84000  took 26 us
[    1.627731] flexcan flexcan.1: 100 read(pwm)     @0x53fb8000  took 23 us
[    1.635358] flexcan flexcan.1: 100 read(i2c1)    @0x63fc0000  took 23 us
[    1.643076] flexcan flexcan.1: 100 read(fec)     @0x63fec000  took 27 us
[    1.650690] flexcan flexcan.1: 100 read(sdma)    @0x63fb0000  took 23 us
[    1.658406] flexcan flexcan.1: 100 read(sram)    @0xf8000000  took 17 us

The IRAM is a bit faster, but not by that much. I don't believe these tests. 
The IRAM is meant to be accessed in a few CLOCKS not a hundred! Maybe it is 
springing an MMU trap on every "I/O" access? That would account for the time.

I think I'm testing this the right way. The inner loop that is reading the 
registers (after calling ioremap() to get an address) is and disassembles to:

             tbase = ioremap(psDev->addr, 4096);
             do_gettimeofday(&now);
             reg = readl(tbase);
             for (i = 0; i < 100; i++)
             {
                 reg = readl(tbase);
             }
             do_gettimeofday(&now2);


  530:   ebfffffe    bl  0 <__arm_ioremap>
  534:   e2504000    subs    r4, r0, #0
...
  558:   e3a03064    mov r3, #100    ; 0x64
  55c:   e5942000    ldr r2, [r4]
  560:   f57ff04f    dsb sy
  564:   e2533001    subs    r3, r3, #1
  568:   e50b2030    str r2, [fp, #-48]  ; 0x30
  56c:   1afffffa    bne 55c <flexcan_probe+0x55c>
...

If I generate code that abuses "volatile" to read the registers, but leaves 
the "dsb" out the time for the loop drops to 18ms (180ns/read) for registers 
and 13us for the IRAM (130ns/read or still 100 CPU clocks at 800MHz).

I can believe the IO Registers are that slow but why should the internal SRAM 
shouldn't be that slow?

Tom


