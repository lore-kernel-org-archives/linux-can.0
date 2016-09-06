From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: [PATCH] can: sja1000: Optimise register accesses
Date: Tue, 6 Sep 2016 19:22:31 +0300
Message-ID: <CAEJ7JO1BRcMux59srO6VMW8jBXn8ycMy_U-ir2ke65pzXrS+UQ@mail.gmail.com>
References: <20160905175852.1513-1-nebaruzdin@gmail.com> <20160905175852.1513-2-nebaruzdin@gmail.com>
 <9a11af52-faf8-b784-8387-9ee48a6ed744@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36807 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbcIFQWw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Sep 2016 12:22:52 -0400
Received: by mail-oi0-f66.google.com with SMTP id u131so6605912oif.3
        for <linux-can@vger.kernel.org>; Tue, 06 Sep 2016 09:22:52 -0700 (PDT)
In-Reply-To: <9a11af52-faf8-b784-8387-9ee48a6ed744@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Sep 5, 2016 at 10:56 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hello Nikita,
>
> On 09/05/2016 07:58 PM, Nikita Edward Baruzdin wrote:
>>
>> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
>> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
>
>
> I definitely like this patch.
>
>> Thus, this patch introduces plx_pci_read_reg_rep() and
>> plx_pci_write_reg_rep() functions that use ioread32()/iowrite32() for
>> register accesses as much as possible. The functions are then used to
>> read/write CAN ID and payload data to improve driver performance.
>
>
> But there is something more to do as you currently brake all sja1000 drivers
> except plx_pci ;-)
>
> You need to take care of drivers that do not support
> priv->[read|write]_reg_rep().
>
> So that other (pci) drivers can follow at will after testing.

Thanks! I'm sorry for being so sloppy :/
I will resend the patch.

> Additionally:
>
> You always take care of the CPU endian when reading writing CAN identifiers.
> Why is it ok to use read_reg_rep() for the CAN data content without any
> beXX_to_cpu() conversion?

beXX_to_cpu() is there just because CAN ID is stored in device registers in the
big-endian manner. The old code actually does the same byte reordering manually
with shifts.

However, I've now realised that current plx_pci_read/write_reg_rep()
implementations won't work with big-endian CPUs as ioreadXX()/iowriteXX()
assume the driver data needs to be cpu-endian while it really needs to be
little-endian since it is treated as a byte array.

Will it be ok, if I add cpu_to_leXX()/leXX_to_cpu() and change functions like
this? I've checked this is still correct with Intel CPU.

>static void plx_pci_read_reg_rep(const struct sja1000_priv *priv, int reg,
>                                 void *buffer, unsigned long count)
>{
>    u8 *p = buffer;
>
>    while (count >= 4) {
>        *(u32 *)p = cpu_to_le32(ioread32(priv->reg_base + reg));
>        p += 4;
>        reg += 4;
>        count -= 4;
>    }
>    if (count & 2) {
>        *(u16 *)p = cpu_to_le16(ioread16(priv->reg_base + reg));
>        p += 2;
>        reg += 2;
>    }
>    if (count & 1)
>        *p = ioread8(priv->reg_base + reg);
>}
>
>static void plx_pci_write_reg_rep(const struct sja1000_priv *priv, int reg,
>                                  const void *buffer, unsigned long count)
>{
>    const u8 *p = buffer;
>
>    while (count >= 4) {
>        iowrite32(le32_to_cpu(*(u32 *)p), priv->reg_base + reg);
>        p += 4;
>        reg += 4;
>        count -= 4;
>    }
>    if (count & 2) {
>        iowrite16(le16_to_cpu(*(u16 *)p), priv->reg_base + reg);
>        p += 2;
>        reg += 2;
>    }
>    if (count & 1)
>        iowrite8(*p, priv->reg_base + reg);
>}
