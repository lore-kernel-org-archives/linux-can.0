From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Support of MCP2515 and AM35x High-End CAN controller in (RT-)SocketCAN
Date: Wed, 02 May 2012 10:12:13 +0200
Message-ID: <4FA0EC5D.4090602@grandegger.com>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com> <CAKG=6c4wMX4ZWFKAxN81-Rnf07wG1vqL96q0e78oe+VjsLSNrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60055 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab2EBIMT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 May 2012 04:12:19 -0400
In-Reply-To: <CAKG=6c4wMX4ZWFKAxN81-Rnf07wG1vqL96q0e78oe+VjsLSNrA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Cc: linux-can@vger.kernel.org

Hi Marcus,

On 05/02/2012 09:51 AM, Marcus Liebhardt wrote:
> Hi everybody!
> 
> Looking for a low-cost solution for a real-time Linux system with CAN
> bus support, I am currently considering the Beaglebone [1] (similar to
> the Beagleboard) with the addition of a CAN bus cape [2]. The later
> provides two MCP2515 CAN controller and also allows the use of the
> integrated CAN controller [3] of the Beaglebone's ARM microprocessor
> (Cortex A8) .
> 
> I am thinking about using a Linux kernel plus the RT-patch
> (CONFIG_PREEMPT_RT), since it seems to be less work then setting up
> Xenomai and the MCP2515 is already supported by SocketCAN. However, I
> am not sure, if this set-up will satisfy our real-time constraints,
> since SocketCAN is not real-time safe. Furthermore, I couldn't find
> information about working solutions of patched Linux kernels on the
> Beaglebord besides this paper [4].
> Hence, I am also looking into the option of using Xenomai on the
> Beaglebone for which I found working examples, such as [4]. However,
> according to this list [5] the MCP2515 is not supported by
> RTcan/RT-SocketCAN. Is this still true?

Setup time is not a strong argument for choosing -rt vs. Xenomai. The
latter usually gives you harder real-time behavior and lower
latencies. On the other hand, Xenomai does not yet support the CAN
controllers you are speaking about. If the Beagleboard is supported by
the mainline 2.6.33 or 3.2 kernel, I think there is a good chance that
the -rt patch applies and works. But I personally don't have any
experience. For real-time and high data rate the MCP2515 is not a really
good choice, as it is connected via SPI bus. What are your requirements
concerning latency and data rate?

> Furthermore, is there support for the integrated CAN controller (AM35x
> HECC) in SocketCAN and/or RT-SocketCAN?

The HECC is supported by the mainline kernel (but not Xenomai).

Wolfgang.
