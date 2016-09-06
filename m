From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: sja1000: Optimise register accesses
Date: Tue, 6 Sep 2016 21:18:41 +0200
Message-ID: <bd27d046-fcbe-ad14-d750-7b136d87097c@hartkopp.net>
References: <20160905175852.1513-1-nebaruzdin@gmail.com>
 <20160905175852.1513-2-nebaruzdin@gmail.com>
 <9a11af52-faf8-b784-8387-9ee48a6ed744@hartkopp.net>
 <CAEJ7JO1BRcMux59srO6VMW8jBXn8ycMy_U-ir2ke65pzXrS+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:13262 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755878AbcIFTSw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Sep 2016 15:18:52 -0400
In-Reply-To: <CAEJ7JO1BRcMux59srO6VMW8jBXn8ycMy_U-ir2ke65pzXrS+UQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/06/2016 06:22 PM, Nikita Edward Baruzdin wrote:
> On Mon, Sep 5, 2016 at 10:56 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> You always take care of the CPU endian when reading writing CAN identifiers.
>> Why is it ok to use read_reg_rep() for the CAN data content without any
>> beXX_to_cpu() conversion?
>
> beXX_to_cpu() is there just because CAN ID is stored in device registers in the
> big-endian manner. The old code actually does the same byte reordering manually
> with shifts.
>
> However, I've now realised that current plx_pci_read/write_reg_rep()
> implementations won't work with big-endian CPUs as ioreadXX()/iowriteXX()
> assume the driver data needs to be cpu-endian while it really needs to be
> little-endian since it is treated as a byte array.
>
> Will it be ok, if I add cpu_to_leXX()/leXX_to_cpu() and change functions like
> this? I've checked this is still correct with Intel CPU.

I assume this will be ok :-)
Please send an updated version, so that Marc can take a look too.

Best regards,
Oliver

