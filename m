From: Alexander Gerasiov <gq@redlab-i.ru>
Subject: Re: [PATCH v2] can: sja1000: Optimise register accesses
Date: Wed, 7 Sep 2016 18:33:16 +0300
Message-ID: <20160907183316.0c2fdc4f@brick.gerasiov.net>
References: <20160907103852.28795-1-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.redlab-i.ru ([195.16.34.155]:53146 "EHLO mail.redlab-i.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757373AbcIGPju (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 7 Sep 2016 11:39:50 -0400
In-Reply-To: <20160907103852.28795-1-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

Hello Nikita,

On Wed,  7 Sep 2016 13:38:52 +0300
Nikita Edward Baruzdin <nebaruzdin@gmail.com> wrote:

> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
> 
> Thus, this patch introduces plx_pci_read_reg_rep() and
> plx_pci_write_reg_rep() functions that use ioread32()/iowrite32() for
> register accesses as much as possible. The functions are then used to
> read/write CAN ID and payload data to improve driver performance.
> 
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>

> @@ -305,19 +306,33 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
>  		fi |= SJA1000_FI_FF;
>  		dreg = SJA1000_EFF_BUF;
>  		priv->write_reg(priv, SJA1000_FI, fi);
> -		priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
> -		priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
> -		priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
> -		priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
> +		if (priv->write_reg_rep) {
> +			*(u32 *)id_buf = cpu_to_be32(id << 3);
> +			priv->write_reg_rep(priv, SJA1000_ID1, id_buf, 4);
> +		} else {
> +			priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
> +			priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
> +			priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
> +			priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
> +		}

Nikita, as I said before, I believe that this should be implemented in
slightly different way.

sja1000.c should have
static void sja1000_read_reg_rep(u8 *buf, size_t size)
{
	unsigned pos = 0;
	while(pos < size){
		priv->read_reg(buf[pos]);
		pos++;
	}
}

and priv->read_reg_rep = sja1000_read_reg_rep;

But in plx_pci.c you implement optimized version
static void plx_pci_read_reg_rep()
{
}

and assign it to priv->read_reg_rep

The same thing should be done with write functions.

Then you call _reg_rep functions everywhere in the code (where you read/write
more then one register).

-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
