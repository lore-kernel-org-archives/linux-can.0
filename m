From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 10:20:30 +0200
Message-ID: <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
References: <5555A6A3.7090206@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34247 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933440AbbEOIUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 04:20:51 -0400
Received: by ieczm2 with SMTP id zm2so26884223iec.1
        for <linux-can@vger.kernel.org>; Fri, 15 May 2015 01:20:50 -0700 (PDT)
In-Reply-To: <5555A6A3.7090206@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaulier?= <fbeaulier@orange.fr>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, May 15, 2015 at 9:56 AM, Fran=C3=A7ois Beaulier <fbeaulier@oran=
ge.fr> wrote:
> Hi,
>
> I'm starting the design of a CPU board, based on a computer on module=
 with a
> very common SOC like i.mx6 or am335x.
> I need to fit my board with at least 10 CAN ports, may be more. (The =
SOC
> have 2 CANs so i need 8 more)
> The board will run with Linux and of course i want a socketcan interf=
ace for
> each bus !
> CAN bitrate needed is quite low (50kbps) and latency is not critical =
but bus
> load may reach 100% sometimes.
> As far as possible i want to avoid driver development, or just doing =
slight
> modifications on an existing driver.
> I don't want to use MCP2515, i had trouble with it on a previous desi=
gn
> because of the lack of buffer in the chip.
> I can't imagine putting 8 MCP2515 and not missing any frame, but may =
be i'm
> wrong ?
>
> Here are the options i have considered, they involve using external M=
CUs to
> provide enough CAN interfaces :
>
> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it sho=
uld
> offer enough performance at low data rate. Problem is that it would r=
equire
> 8 UARTS. I could modify SLCAN driver to allow multiple CAN channels o=
n the
> same UART, and so use MCUs with multiple CANs, does it sounds reasona=
ble ?
>
> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI pro=
tocol
> manageable on the MCU side (SPI slave). The MCU will be able to provi=
de the
> buffer for CAN frames that the MCP does not have. This option is just=
 a way
> of trying to go fast, it is not very elegant, and have the limitation=
 of one
> CAN channel per SPI connection / driver instance.
>
> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on this l=
ist.
> This is probably the best choice for a long term and more generic sol=
ution.
> But i'm afraid it may require too much work to complete. What is the =
status
> of this driver right now ? Does anyone have an idea of the remaining =
work to
> do to make it ready for mainline ? Stefano are you available to spend=
 more
> time on it ? I'm also wondering whether multiple instances of the dri=
ver can
> run concurently if i put more than one MCU ?
>
> Concerning the MCU software i could release it as an open-source proj=
ect,
> anyone interested in participating ?
> I'm very familiar with STM32 MCUs so i will probably use an STM32F072=
 (low
> cost cortex M0 with one CAN).
>
> Any idea or advice is welcome, thank you for reading this much too lo=
ng
> post.

Is it possible to attach 8 SJA1000s over local bus? The driver is
already in mainline kernel.

Yegor
