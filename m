From: Alexander Gerasiov <gq@redlab-i.ru>
Subject: Re: [PATCH v3] can: sja1000: Optimise register accesses
Date: Thu, 8 Sep 2016 11:36:07 +0300
Message-ID: <20160908113607.7b7e7ca8@brick.gerasiov.net>
References: <20160908080613.3997-1-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.redlab-i.ru ([195.16.34.155]:38712 "EHLO mail.redlab-i.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936532AbcIHIgM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 8 Sep 2016 04:36:12 -0400
In-Reply-To: <20160908080613.3997-1-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Nikita,

On Thu,  8 Sep 2016 11:06:13 +0300
Nikita Edward Baruzdin <nebaruzdin@gmail.com> wrote:

> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
> 
> Thus, this patch introduces [read|write]_reg_rep() interface functions
> that are used to read/write CAN ID and payload data.
> 
>   * For plx_pci driver this interface is implemented as
>     plx_pci_[read|write]_reg_rep() that use ioread32()/iowrite32() for
>     register accesses as much as possible to improve driver
> performance.
> 
>   * For other drivers the default implementation,
>     sja1000_[read|write]_reg_rep(), is used for now. These functions
>     still access registers in a series of ioread8()/iowrite8() calls.

This looks OK for me. (I hope you didn't forget to run tests with this
variant. And with default implementation of rep functions too.)


It would be good if someone run tests with other plx_pci based adapters
(they should also work with 32 bit access via PCI, but who knows).
Tests with other sja1000 cards and on big-endian boxes are welcome too.



-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
