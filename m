From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v7 2/4] can: m_can: Rename m_can_priv to m_can_classdev
Date: Fri, 8 Mar 2019 11:25:35 +0100
Message-ID: <1138f22c-028c-184a-19c0-5b8f64bd977f@grandegger.com>
References: <20190305155220.14037-1-dmurphy@ti.com>
 <20190305155220.14037-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190305155220.14037-2-dmurphy@ti.com>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



Am 05.03.19 um 16:52 schrieb Dan Murphy:
> Rename the common m_can_priv class structure to
> m_can_classdev as this is more descriptive.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v7 - Fixed remaining checkpatch issues, renamed priv to cdev - https://lore.kernel.org/patchwork/patch/1047219/
> 
> v6 - No changes only rebase changes possibly can squash into the first patch - 
> https://lore.kernel.org/patchwork/patch/1042444/
> 
>  drivers/net/can/m_can/m_can.c          | 524 ++++++++++++-------------
>  drivers/net/can/m_can/m_can.h          |  28 +-
>  drivers/net/can/m_can/m_can_platform.c |  16 +-
>  3 files changed, 284 insertions(+), 284 deletions(-)

...snip...

> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index b60f27dd9f33..1299cc747194 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -57,19 +57,19 @@ struct mram_cfg {
>  	u8  num;
>  };
>  
> -struct m_can_priv;
> +struct m_can_classdev;
>  struct m_can_ops {
>  	/* Device specific call backs */
> -	int (*clear_interrupts)(struct m_can_priv *m_can_class);
> -	u32 (*read_reg)(struct m_can_priv *m_can_class, int reg);
> -	int (*write_reg)(struct m_can_priv *m_can_class, int reg, int val);
> -	u32 (*read_fifo)(struct m_can_priv *m_can_class, int addr_offset);
> -	int (*write_fifo)(struct m_can_priv *m_can_class, int addr_offset,
> +	int (*clear_interrupts)(struct m_can_classdev *m_can_class);
> +	u32 (*read_reg)(struct m_can_classdev *m_can_class, int reg);
> +	int (*write_reg)(struct m_can_classdev *m_can_class, int reg, int val);
> +	u32 (*read_fifo)(struct m_can_classdev *m_can_class, int addr_offset);
> +	int (*write_fifo)(struct m_can_classdev *m_can_class, int addr_offset,

Could you please replace the variable name "m_can_class" with "cdev"
here and below and in "c_can_platform.c " and "tcan4x5x.c" as well.

Thanks,

Wolfgang.
