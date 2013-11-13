From: T Thayer <tthayer.linux@gmail.com>
Subject: Re: Question about D_CAN implementation
Date: Wed, 13 Nov 2013 09:31:05 -0600
Message-ID: <CAF03EBe+KwDQazCcQ6=bBrMkOYs2NLmeeKtw7tczz=hp-wUNPA@mail.gmail.com>
References: <CAF03EBfWAS=JG923ainNts0zqnCKGfBTbNWihC8qsFXu6QfwGg@mail.gmail.com>
	<5282B09B.6020307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:37959 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376Ab3KMPbG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2013 10:31:06 -0500
Received: by mail-vb0-f43.google.com with SMTP id w20so389569vbb.2
        for <linux-can@vger.kernel.org>; Wed, 13 Nov 2013 07:31:05 -0800 (PST)
In-Reply-To: <5282B09B.6020307@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tue, Nov 12, 2013 at 4:50 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 11/12/2013 11:30 PM, T Thayer wrote:
>> I'm experimenting with the combined C_CAN/D_CAN Linux driver for the
>> Altera CycloneV SoC which uses the Bosch D_CAN module..
>>
>> I'm having some problems though. Specifically, I'm seeing 2 copies of
>> a frame get transmitted.
>
> Where do you see 2 copies of the frame?

I see 2 copies on a different board running the same c_can as well as
with a CAN Bus analyzer (Microchip).

>
>> Strangely, the IRQ Status register = 0x800A inside the c_can_poll()
>> function indicates a RX message object (0 <  RX < 16) instead of a TX
>> message object.
>>
>> If I use the standalone D_CAN driver which was in the
>> drivers/net/can/d_can directory, it seems to work fine (IRQ Status =
>> 0x8011). I believe this directory was removed when the c_can and d_can
>> drivers were combined (SHA 69927fccd96b15bd228bb82d)
>
> There never was a mainline kernel with drivers/net/can/d_can.
>

OK. Thank you for this clarification.

>> I noticed some significant differences - particularly in the
>> c_can_poll() function.
>> IRQ Status Test.
>> - d_can.c ANDs the irqstatus with STATUS_INTERRUPT
>> - c_can.c checks to see if the irqstatus == STATUS_INTERRUPT.
>> After IRQ Status Test.
>> - d_can.c has a separate if/else if loop to determine whether the
>> Message was RX/TX
>> - c_can.c has is a continuation of the IRQ status test (else if, else if)
>>
>> Another symptom is that the tx_packet statistics aren't incrementing
>> as I send data. However, this may be related to the IRQ indicating a
>> RX message object.
>>
>> Thank you for any insight you may have,
>
> Marc
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>

Below is a trace of the program flow after a transmit. I was expecting
to get interrupted with a 0x8011 but I'm getting a 0x800A.
My notes have << >> around them.

root@socfpga_cyclone5:~# cansend can0 -i 0x123 x011 0x22 0x33 0x44
interface = can0, family = 29, type = 3, proto = 1
CAN Start Xmit 17.
<<c_can_start_xmit() after msg_obj_no>>
It will send can frame with 0 us interval!
CAN Write Message Object 17
<<c_can_write_msg_object() @ entry >>
CAN Object Put (17)
<<c_can_object_put() @ entry>>
CAN Poll. IRQ Status = 0x0000800A.
<<c_can_poll() before NULL irqstatus test>>
CAN Poll. IRQ Status = 0x0000000A.                                  ""
CAN Poll. Keep RXing.
<<else if irqstatus > RX_FIRST && irqstatus < RX_LAST>>
CAN Do RX Poll
 <<c_can_do_rx_poll() before for loop>>
CAN Object Get
 <<c_can_object_get() @ entry>>

Thanks,

Thor
