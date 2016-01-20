From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Wed, 20 Jan 2016 14:51:11 +0000
Message-ID: <20160120145111.GA1044@maxwell.marel.net>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0085.outbound.protection.outlook.com ([157.55.234.85]:48878
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751367AbcATPY7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 20 Jan 2016 10:24:59 -0500
Content-Disposition: inline
In-Reply-To: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi,

I wouldn't say it's a "potential" frame loss issue. It's a confirmed TX frame
loss issue.

On Wed, Jan 20, 2016 at 12:15:32PM +0100, Stephane Grosjean wrote:
> This patch installs a workaround when the driver detects one of the
> following PEAK-System CAN interfaces, running a firmware < v1.3.0:
> 
> PCAN-PCI Express 1/2/4 CAN; DeviceID 0x0003
> PCAN-PCI/104 Express 1/2/4 CAN; DeviceID 0x0007
> PCAN-miniPCIe 1/2 CAN; DeviceID 0x0008
> PCAN-PCI Express OEM 1/2/4 CAN; DeviceID 0x0009
> PCAN-ExpressCard 34 1 CAN; DeviceID 0x000A
> 
> This fixes potential loss of one tx frame in Linux SMP when some other
> task does another Command Register write (e.g. Release Receive Buffer)
> in between the triggering Tx Request and the next Sample Point.
> 
> This workaround is useless thus *NOT* installed when the firmware
Nitpick: I don't think that you mean to say that the patch you're posting is
useless. Perhaps you want to rephrase. ;)

> has been upgraded to v1.3.0 or higher, nor if the CAN interface is equipped
> with true SJA1000 controller(s).
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Reported-by: Andri Yngvason <andri.yngvason@marel.com>

> ---
>  drivers/net/can/sja1000/peak_pci.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
> index 131026f..84f7d3a 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -30,6 +30,15 @@
[...]
>  static void peak_pci_post_irq(const struct sja1000_priv *priv)
>  {
>  	struct peak_pci_chan *chan = priv->priv;
> @@ -559,6 +581,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	void __iomem *cfg_base, *reg_base;
>  	u16 sub_sys_id, icr;
>  	int i, err, channels;
> +	u32 v1, v2 = 0;
>  
>  	err = pci_enable_device(pdev);
>  	if (err)
> @@ -612,6 +635,12 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* Leave parport mux mode */
>  	writeb(0x04, cfg_base + PITA_MISC + 3);
>  
> +	v1 = readl(cfg_base + VERSION_REG1);
Nitpick: It's easier on my internal parser if you make this
	is_fpga = !!readl(cfg_base + VERSION_REG1);

> +	if (v1) {
> +		/* FPGA card */
> +		v2 = readl(cfg_base + VERSION_REG2);
... and this
		fpga_version = readl(cfg_base + VERSION_REG2);

> +	}
> +
[...]

Thanks,
Andri
