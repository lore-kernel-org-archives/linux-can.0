Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059445198F;
	Wed,  9 Sep 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942264; cv=none; b=hpHeYvjFZi4PdV7iEqAmOXJcNp1f69p4Fjp7Y/nO+uu1x623Q76GRVp5DrMdSKB3M1giDiWOaScZ6J5Dlw5ulR9e0Kc0JCy3bD0TuSsLL/N5k4BOlIPSeRcQu+Emnn4CkWb9I2KrMSBj8zoAOP2kINkCfxMsaxJej8xCVCNi+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942264; c=relaxed/simple;
	bh=mR91vloxV6Hp66WTXzqOaUNBRbGtfUkKENJ2XwBeD1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5GQsoBWzmPhNnl4sbuEjn53AIaPybcYWGopQmXGmBAwjV949DfOwQ+ByAef+3xap2CaWQUICmPX8tSpvax/V+7ZkhkxkloMYD8yc9WxtPNoZ/G+FHI2TLR889bdWyzDAppu0lyoTQlv0/XH49IVzjh9xx6UC+1EAzeAV3PiuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NordMoUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NordMoUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4A41F00A3A;
	Wed,  9 Sep 2026 08:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788942262;
	bh=0mroZzVdGpauTVtWMXSdkV71fbKcgK+KZHBfEpQg5Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NordMoUk9DXgi2iqJT+k1El9CrYoWpfiHN8+oyuPmhrqdaD9LWcEDlJ5ZFlFl3r0w
	 Y3N2MK/+i/CswtnxS+PcRPYMYoamTbSgkor6RnXOM/hh0adSdAOHyW0qp6gOeAByeA
	 IO9DS0V3eGb96fJkxVfBtIJnM1XHfDHVlIYUrjuTps5L7DnMnUPZ+0OTd1XwvIZbiU
	 9OyCarX+e428UV8lYdgaGK0I46vquuhkVHGswXeZo3BsDfraIiuE76b33cL9EqDTx7
	 BhoBBRu+jdzlnKYYuF+RfInm2o2XpA8H8pvvpsfOf/Kjfza6fh+SpTLjJA2z6CqdWM
	 sC59myHTrlQhg==
Date: Wed, 9 Sep 2026 10:24:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, richard.genoud@bootlin.com, Udit Kumar <u-kumar1@ti.com>, 
	Abhash Kumar <a-kumar2@ti.com>, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: phy-can-transceiver: Add suspend operation for
 tcan1043
Message-ID: <3tmfs4ou7hrw6y35to6ugnwz5445h5bjapfhyfwoviqrgk3jy2@47imiewocfaz>
References: <20260630-phy-can-transceiver-suspend-resume-support-v1-1-6842c2d697e4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630-phy-can-transceiver-suspend-resume-support-v1-1-6842c2d697e4@bootlin.com>

On Tue, Jun 30, 2026 at 02:28:46PM +0200, Thomas Richard (TI) wrote:
> Add suspend operation for tcan1043. It switches the PHY in Sleep mode, the
> lowest power mode of the device. If a bus wake-up pattern or a local
> wake-up event occurs, the PHY transitions to Standby mode, set its internal
> WAKERQ flag and set the INH output high. In Sleep mode INH is floating.
> 
> The WAKERQ flag prevents transition to Go-to-Sleep mode. The only way to
> clear it is to switch to Normal mode. So to reach Sleep mode, we firstly
> switch to Normal mode, then to Go-to-Sleep mode.
> 
> Suspend sequence (PHY is off):
> 
>     Standby -> Normal -> Go-to-Sleep -> Sleep
> 
> Suspend sequence (PHY is on):
> 
>     Normal -> Go-to-Sleep -> Sleep
> 
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 56 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 75dc49e75ca0..2bca1a173fcc 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
>   *
>   */
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -12,25 +13,28 @@
>  #include <linux/module.h>
>  #include <linux/mux/consumer.h>
>  
> +struct can_transceiver_phy {
> +	struct phy *generic_phy;
> +	struct gpio_desc *silent_gpio;
> +	struct gpio_desc *standby_gpio;
> +	struct gpio_desc *enable_gpio;
> +	struct can_transceiver_priv *priv;
> +};
> +
>  struct can_transceiver_data {
>  	u32 flags;
>  #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
>  #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
>  #define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
>  #define CAN_TRANSCEIVER_SILENT_PRESENT	BIT(3)
> +	int	(*suspend)(struct can_transceiver_phy *phy);
>  };
>  
> -struct can_transceiver_phy {
> -	struct phy *generic_phy;
> -	struct gpio_desc *silent_gpio;
> -	struct gpio_desc *standby_gpio;
> -	struct gpio_desc *enable_gpio;
> -	struct can_transceiver_priv *priv;
> -};
>  
>  struct can_transceiver_priv {
>  	struct mux_state *mux_state;
>  	int num_ch;
> +	const struct can_transceiver_data *data;
>  	struct can_transceiver_phy can_transceiver_phy[] __counted_by(num_ch);
>  };
>  
> @@ -76,12 +80,28 @@ static const struct phy_ops can_transceiver_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static int tcan1043_suspend(struct can_transceiver_phy *phy)
> +{
> +	/* Switch to Normal mode, it clears WAKERQ */
> +	gpiod_set_value_cansleep(phy->standby_gpio, 0);
> +	gpiod_set_value_cansleep(phy->enable_gpio, 1);
> +
> +	/* Switch to Go-to-Sleep mode */
> +	gpiod_set_value_cansleep(phy->standby_gpio, 1);
> +
> +	/* Wait transition to Sleep mode */
> +	fsleep(5);
> +
> +	return 0;
> +}
> +
>  static const struct can_transceiver_data tcan1042_drvdata = {
>  	.flags = CAN_TRANSCEIVER_STB_PRESENT,
>  };
>  
>  static const struct can_transceiver_data tcan1043_drvdata = {
>  	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
> +	.suspend = tcan1043_suspend,
>  };
>  
>  static const struct can_transceiver_data tja1048_drvdata = {
> @@ -115,6 +135,26 @@ static struct phy *can_transceiver_phy_xlate(struct device *dev,
>  	return priv->can_transceiver_phy[idx].generic_phy;
>  }
>  
> +static int can_transceiver_phy_suspend(struct device *dev)
> +{
> +	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
> +	const struct can_transceiver_data *data = priv->data;
> +	int ret, i;
> +
> +	for (i = 0; i < priv->num_ch; i++) {
> +		if (data->suspend) {
> +			ret = data->suspend(&priv->can_transceiver_phy[i]);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(can_transceiver_phy_pm_ops,
> +				can_transceiver_phy_suspend, NULL);

I believe you didn't add resume() callback here based on the assumption that the
CAN transceiver driver will call phy_power_off() during suspend and
phy_power_on() during resume. But that implicit assumption is wrong since the
PHY driver should act on its own and not rely on the consumer's behavior. In
that sense, resume() callback should be present and it should undo suspend().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
