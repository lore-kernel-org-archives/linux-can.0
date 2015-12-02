From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: peak_pci: TX Frame Loss
Date: Wed, 02 Dec 2015 20:19:21 +0100
Message-ID: <565F4439.3050309@hartkopp.net>
References: <20151118145121.32487.38169@maxwell.marel.net> <20151202180937.19023.96078@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:64504 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbbLBTTZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2015 14:19:25 -0500
In-Reply-To: <20151202180937.19023.96078@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, s.grosjean@peak-system.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com



On 12/02/2015 07:09 PM, Andri Yngvason wrote:
> Quoting Andri Yngvason (2015-11-18 14:51:21)
> [...]
>> We've been experiencing frame loss on transmission in the peak_pci netdev
>> driver.
> [...]
> 
> Hi all,
> 
> I think I've figured it out.
> 
> I wrote two programs: One that sends out bursts of can frames with the same
> can_id but increasing data[0] and one that listens to can frames and stops
> ftrace when a frame is missing. These programs also place ftrace markers.
> See link below [1].
> 
> In cases where frames were lost sja1000_write_cmdreg() is called from two cores
> at the same time.
>  
>  7)               |                sja1000_interrupt [sja1001]() {
>  [...]
>  3)               |            raw_sendmsg [can_raw]() {
>  [...]
>  3)               |                      dev_hard_start_xmit() {
>  3)               |                        sja1000_start_xmit [sja1000]() {
>  7)   2.071 us    |                  peak_pci_read_reg [peak_pci]();
>  3)   3.901 us    |                          peak_pci_read_reg [peak_pci]();
>  [...]
>  7)   2.066 us    |                  peak_pci_read_reg [peak_pci]();
>  3)   0.139 us    |                          can_put_echo_skb [can_dev]();
>  3)               |                          sja1000_write_cmdreg [sja1000]() {
>  start_xmit acquires spin lock:
>  3)   0.050 us    |                            _raw_spin_lock_irqsave();
>  start_xmit writes to command register:
>  3)   0.043 us    |                            peak_pci_write_reg [peak_pci]();
>  3)   2.516 us    |                            peak_pci_read_reg [peak_pci]();
>  7)               |                  sja1000_write_cmdreg [sja1000]() {
>  sja1000_interrupt from other thread stalls on spin lock:
>  7)   2.035 us    |                    _raw_spin_lock_irqsave();
>  start_xmit releases spin lock:
>  3)   0.083 us    |                            _raw_spin_unlock_irqrestore();
>  sja1000_interrupt continues and writes to command register:
>  7)   0.057 us    |                    peak_pci_write_reg [peak_pci]();
>  3)   4.456 us    |                          }
>  3) + 21.813 us   |                        }
>  7)   1.657 us    |                    peak_pci_read_reg [peak_pci]();
>  3) + 22.632 us   |                      }
>  3)   0.044 us    |                      _raw_spin_lock();
>  3) + 26.822 us   |                    }
>  3)   0.105 us    |                    __local_bh_enable_ip();
>  3) + 30.474 us   |                  }
>  3) + 30.985 us   |                }
>  sja1000_interrupt releases spin lock:
>  7)   0.072 us    |                    _raw_spin_unlock_irqrestore();
> 
>  As far as locking goes, this looks OK, but maybe the sja1000 (or peak's FPGA
>  implementation thereof) hasn't settled after writing to the command register?
> 
>  I tried adding a delay to test my theory:
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index f968d1e..b5115c2 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -93,6 +93,7 @@ static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
>  	spin_lock_irqsave(&priv->cmdreg_lock, flags);
>  	priv->write_reg(priv, SJA1000_CMR, val);
>  	priv->read_reg(priv, SJA1000_SR);
> +	udelay(10);
>  	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
>  }

Hi Andri,

looking at the code above I wonder whether the

	priv->read_reg(priv, SJA1000_SR);

is a bad hack anyway.

The read_reg() becomes readb(priv->reg_base + (port << 2)) in peak_pci.c and
the result is never used.

What if the entire operation gets 'optimized' at some point?

Can you check what happens if you just replace the priv->read_reg() with your
udelay(10) call?

Best regards,
Oliver


>  
> I've been running the test programs for a while now and I haven't lost a frame
> yet, so this delay seems to solve the problem.
> 
> Do you guys think that this is an acceptable solution?
> Should it maybe reside within peak_pci.c instead?
> 
> Regards,
> Andri
> 
> [1] https://gist.github.com/any1/7062000f8c02b9b27bf6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
