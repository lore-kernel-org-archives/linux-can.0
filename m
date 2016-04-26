From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH] sllin: update for kernels > 3.11
Date: Tue, 26 Apr 2016 02:34:35 +0200
Message-ID: <201604260234.35367.pisa@cmp.felk.cvut.cz>
References: <571E9E5D.3000806@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp7.web4u.cz ([81.91.87.87]:55686 "EHLO mx-8.mail.web4u.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750963AbcDZAlO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 25 Apr 2016 20:41:14 -0400
In-Reply-To: <571E9E5D.3000806@gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Hendrix <namniart@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Austin,

On Tuesday 26 of April 2016 00:46:53 Austin Hendrix wrote:
> I'm experimenting with sllin ( https://rtime.felk.cvut.cz/can/lin-bus/
> ), and I've found that it doesn't compile on linux kernels newer than
> 3.11, so I've patched it to compile and (hopefully) run on newer kernels.

I have pushed your patch to our (CTU) repository.
The changes looks good and your report that code
build should be enough evidence that these changes
are going in the right direction for newer kernels.

We need to find more time to recheck driver functionality
but we do not have any LIN project running at this moment
and are too busy with other projects. But next round of testing
is no my long long TODO list.

The simple RS-232 to LIN converter hardware is described
in the RTLWS paper

  https://rtime.felk.cvut.cz/can/sllin-rtlws14-paper.pdf

There are some other related document on our CAN and LIN
related pages

  https://rtime.felk.cvut.cz/can/lin-bus/

The proper converter from TTL or RS-232 UART to LIN
could be build with use of some standard compliant LIN
transceiver chip.

Generally, code should work with all kinds of UART drivers
except for the case when slLIN operates as device and is
asked to send response. In such case there can be problem
that UART with FIFO usually waits for four character times
before it reports received characters if FIFO does not reach
Rx FIFO trigger level. If the other side LIN master is strict
and response does not start in two character times then
it reports error. The trigger level can be set to single
character for many embedded UARTs or Rx FIFO can be disabled
completely. But there there has been problem in the past
that Linux termios based serial ports did not expose interface
to setup trigger level only limited trigger level to one for
baudrates < 2400.

But when I analyze actual standard PC/8250 based driver code

  drivers/tty/serial/8250/8250_port.c


        if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
                /* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
                if ((baud < 2400 && !up->dma) || up->fifo_bug) {
                        up->fcr &= ~UART_FCR_TRIGGER_MASK;
                        up->fcr |= UART_FCR_TRIGGER_1;
                }
        }

  static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)

  static DEVICE_ATTR(rx_trig_bytes, S_IRUSR | S_IWUSR | S_IRGRP,
                   serial8250_get_attr_rx_trig_bytes,
                   serial8250_set_attr_rx_trig_bytes);

There is defined new attribute to select trigger level from userspace,
so this problem should be easily eliminated by setting trigger level
to one character

  echo 1 > /sys/class/tty/ttyS0/rx_trig_bytes

We have used hack in the past to modify port trigger level,
now it is much easier.

There are alternatives for some other hardware. Look for device
attributes or module parameters with rx_trigr in the name
or rx_timeout

  MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");

  MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");

It would be great if you can report results of your testing.

Best wishes,

              Pavel
