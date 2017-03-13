From: Efim Monjak <emonjak@lipowsky.de>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 16:17:56 +0100
Message-ID: <3ce9a121-ec02-c671-b2b7-0b259238da82@lipowsky.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
 <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
 <1b40816e-7102-739a-4738-30547d68b523@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from server1.railshosting.de ([5.45.177.35]:45340 "EHLO
        server1.railshosting.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753373AbdCMORh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 10:17:37 -0400
In-Reply-To: <1b40816e-7102-739a-4738-30547d68b523@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On 03/13/2017 02:11 PM, Marc Kleine-Budde wrote:
> On 03/13/2017 01:55 PM, Efim Monjak wrote:
>>>> In fact I always thought NAPI is too heavy for CAN controllers. NAPI was
>>>> intended for a very high interrupt load on some ethernet controllers
>>>> with some considerable RX FIFO.
>>>>
>>>> I have a 20 CAN interfaces (SJA1000 driver) Core i7 system receiving
>>>> ~22.000 frames/s without any problems, with an one-element FIFO and
>>>> without NAPI.
>>>>
>>>> @Marc: What was the reason to implement NAPI that days? Has it ever been
>>>> proved that NAPI had a remarkable positive effect in opposite to a
>>>> direct CAN frame processing in the interrupt context?
>>> On SMP systems the network stack doesn't seem to guarantee the order of
>>> frames when put into the stack in IRQ context.
>> As I see Socketcan use a default queuing discipline pfifo_fast.
>> This use 3 bands with different priorities, may be here is a problem?
> No, queue disciplines are in the TX path, I was talking about RX.
>
>> As I test my application I see a queue of about 163000 bytes can
>> contain only 320 CAN frames. It seems the fifo is not configure for
>> CAN frames though used PDU is 16 bytes.
> Which queue do you mean exactly? Maybe it's the sum of skbs not the
> can_frames.
>
> Marc
>
I am using Kernel 4.4.27. By getsocketopt() it is possible to get 
maximum receive buffer size in bytes.

if (getsockopt(sock, SOL_SOCKET, SO_RCVBUF, (void*)&n, &m) == 0)      
fprintf(stderr, "\nCAN Rx Bufsize %u bytes", n);

As I understand as long as no CAN frame is read from socket by user 
application all received CAN frames will be stored into this buffer by 
CAN driver. If more CAN frames are received as receive buffer able to 
contain a buffer overflow occurs and CAN frames goes lost.
For test proposes the application opened  a socket and was stopped by debugger
after it. The result of getsockopt() was a bit more as 163000 bytes. 
After it CAN frames was sent for about 1..2 min. It is enough time to 
get receive buffer overflow. Now sending of CAN frames was stopped and 
the application have read all CAN frames stored in the socket and 
counted them. It was 320. For test I have set size of receive buffer to 
value was read from socket (about 163000). After it number of received 
CAN frames was 640.
I think skbs are stored into receive buffer/queue.

Efim

