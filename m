From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 11:26:38 +0100
Message-ID: <50D2E7DE.5030808@grandegger.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60459 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab2LTK0n (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 05:26:43 -0500
In-Reply-To: <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com

On 12/20/2012 11:05 AM, Amit Virdi wrote:
> Depending on the underlying platform, the configuration of the c-can
> message objects can change. For e.g. in some systems, it makes more
> sense to receive many message objects and transmit very few. In any
> case, providing flexibility in configuring the message objects is highly
> desirable.
> 
> The total number of message objects for C_CAN controller is fixed at 32.
> The receive message objects are assigned higher priority so they begin
> with message object#1. So, in order to configure the message object the
> driver just needs two parameters - rx_split (for differentiating between
> lower bucket and higher bucket) and tx_num.

What is your motivation to make this configurable?
Why is the current default not good enough?

> However, if the user doesn't specify these parameters, then the message
> objects are configured with default parameters with equal distribution
> of receive and transmit message objects (16 each).
> 
> Signed-off-by: Amit Virdi <amit.virdi@st.com>
> Cc: Bhupesh Sharma <bhupesh.sharma@st.com>
> Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
> ---
>  .../devicetree/bindings/net/can/c_can.txt          |  55 ++++++++++--
>  drivers/net/can/c_can/c_can.c                      | 100 ++++++++++++---------
>  drivers/net/can/c_can/c_can.h                      |  16 +++-
>  drivers/net/can/c_can/c_can_platform.c             |  47 +++++++++-
>  4 files changed, 168 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> index 7d645cb..4ddd127 100644
> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -8,20 +8,25 @@ Required properties:
>  			  registers map
>  - interrupts		: property with a value describing the interrupt
>  			  number
> -
>  Optional properties:
> +
>  - ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
>  			  instance number
> +- rx_split      : Receive message objects lying in the lower bucket
> +- tx_num        : Total number of transmit message objects
>  - reg_alignment : Signifies register alignment. Must be either of
>                          1. 0x8 or 0x10 - If registers are 16-bit aligned
>                          2. 0x18 - If registers are 32-bit aligned
>                  Default is 32-bit alignment.

I would prefer "reg_alignment" in bytes. 0x4 is much more readable than
0x18.

> -Note: "ti,hwmods" field is used to fetch the base address and irq
> -resources from TI, omap hwmod data base during device registration.
> -Future plan is to migrate hwmod data base contents into device tree
> -blob so that, all the required data will be used from device tree dts
> -file.
> +Note:
> +1. "ti,hwmods" field is used to fetch the base address and irq resources from
> +   TI, omap hwmod data base during device registration.  Future plan is to
> +   migrate hwmod data base contents into device tree blob so that, all the
> +   required data will be used from device tree dts file.
> +2. Bosch C_CAN controller has 32 total message objects. RX first message object
> +   starts from 1. Depending upon the application, rx_split should lie somewhere
> +   between rx_first and rx_last (32 - tx_num)
>  
>  Example:
>  
> @@ -46,8 +51,46 @@ Step1: SoC common .dtsi file
>  		status = "disabled";
>  	};
>  
> +(or)
> +
> +	can0@a1000000 {
> +		compatible = "bosch,c_can";
> +		ti,hwmods = "c_can0";
> +		reg = <0xa1000000 0x1000>;
> +		interrupts = <55>;
> +		interrupt-parent = <&intc>;
> +		reg_alignment = <0x10>;
> +		status = "disabled";
> +	};
> +
> +(or)
> +
> +	can1@a2000000 {
> +		compatible = "bosch,c_can";
> +		ti,hwmods = "c_can1";
> +		reg = <0xa2000000 0x1000>;
> +		interrupts = <55>;
> +		interrupt-parent = <&intc>;
> +		reg_alignment = <0x18>;
> +		status = "disabled";
> +	};
> +
>  Step 2: board specific .dts file
>  
> +	can0@a1000000 {
> +		rx_split = <16>;
> +		tx_num = <6>;
> +		status = "okay";
> +	};
> +
> +(or)
> +
> +	can1@a2000000 {
> +		status = "okay";
> +	};
> +
> +(or)
> +
>  	&dcan1 {
>  		status = "okay";
>  	};
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 5233b8f..723bcba 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -141,22 +141,12 @@
>  
>  /* message object split */
>  #define C_CAN_NO_OF_OBJECTS	32
> -#define C_CAN_MSG_OBJ_RX_NUM	16
> -#define C_CAN_MSG_OBJ_TX_NUM	16
> -
>  #define C_CAN_MSG_OBJ_RX_FIRST	1
> -#define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
> -				C_CAN_MSG_OBJ_RX_NUM - 1)
> -
> -#define C_CAN_MSG_OBJ_TX_FIRST	(C_CAN_MSG_OBJ_RX_LAST + 1)
> -#define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
> -				C_CAN_MSG_OBJ_TX_NUM - 1)
>  
> -#define C_CAN_MSG_OBJ_RX_SPLIT	9
> -#define C_CAN_MSG_RX_LOW_LAST	(C_CAN_MSG_OBJ_RX_SPLIT - 1)
> +#define C_CAN_MSG_OBJ_RX_LAST(x)	(C_CAN_NO_OF_OBJECTS -\
> +						get_msg_obj_tx_num(x))
>  
> -#define C_CAN_NEXT_MSG_OBJ_MASK	(C_CAN_MSG_OBJ_TX_NUM - 1)
> -#define RECEIVE_OBJECT_BITS	0x0000ffff
> +#define C_CAN_MSG_OBJ_TX_LAST	C_CAN_NO_OF_OBJECTS
>  
>  /* status interrupt */
>  #define STATUS_INTERRUPT	0x8000
> @@ -171,9 +161,6 @@
>  /* Wait for ~1 sec for INIT bit */
>  #define INIT_WAIT_MS		1000
>  
> -/* napi related */
> -#define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
> -
>  /* c_can lec values */
>  enum c_can_lec_type {
>  	LEC_NO_ERROR = 0,
> @@ -239,16 +226,42 @@ static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
>  		priv->raminit(priv, enable);
>  }
>  
> +static inline unsigned int get_msg_obj_rx_split(const struct c_can_priv *priv)
> +{
> +	return priv->pdata->rx_split;
> +}
> +
> +static inline unsigned int get_msg_obj_tx_num(const struct c_can_priv *priv)
> +{
> +	return priv->pdata->tx_num;
> +}
> +
> +static inline unsigned int get_msg_obj_rx_low_last(
> +			const struct c_can_priv *priv)
> +{
> +	return get_msg_obj_rx_split(priv) - 1;
> +}
> +
> +static inline unsigned int get_msg_obj_tx_first(const struct c_can_priv *priv)
> +{
> +	return C_CAN_NO_OF_OBJECTS - get_msg_obj_tx_num(priv) + 1;
> +}
> +
> +static inline unsigned int get_next_msg_obj_mask(const struct c_can_priv *priv)
> +{
> +	return get_msg_obj_tx_num(priv) - 1;
> +}
> +
>  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
>  {
> -	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
> -			C_CAN_MSG_OBJ_TX_FIRST;
> +	return (priv->tx_next & get_next_msg_obj_mask(priv)) +
> +			get_msg_obj_tx_first(priv);
>  }
>  
>  static inline int get_tx_echo_msg_obj(const struct c_can_priv *priv)
>  {
> -	return (priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) +
> -			C_CAN_MSG_OBJ_TX_FIRST;
> +	return (priv->tx_echo & get_next_msg_obj_mask(priv)) +
> +			get_msg_obj_tx_first(priv);
>  }
>  
>  static u32 c_can_read_reg32(struct c_can_priv *priv, enum reg index)
> @@ -384,7 +397,8 @@ static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
>  	int i;
>  	struct c_can_priv *priv = netdev_priv(dev);
>  
> -	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_RX_LOW_LAST; i++) {
> +	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= get_msg_obj_rx_low_last(priv);
> +			i++) {
>  		priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
>  				ctrl_mask & ~(IF_MCONT_MSGLST |
>  					IF_MCONT_INTPND | IF_MCONT_NEWDAT));
> @@ -545,7 +559,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>  
>  	/* prepare message object for transmission */
>  	c_can_write_msg_object(dev, 0, frame, msg_obj_no);
> -	can_put_echo_skb(skb, dev, msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
> +	can_put_echo_skb(skb, dev, msg_obj_no - get_msg_obj_tx_first(priv));
>  
>  	/*
>  	 * we have to stop the queue in case of a wrap around or
> @@ -553,7 +567,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>  	 */
>  	priv->tx_next++;
>  	if (c_can_is_next_tx_obj_busy(priv, get_tx_next_msg_obj(priv)) ||
> -			(priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) == 0)
> +			(priv->tx_next & get_next_msg_obj_mask(priv)) == 0)
>  		netif_stop_queue(dev);
>  
>  	return NETDEV_TX_OK;
> @@ -604,17 +618,18 @@ static int c_can_set_bittiming(struct net_device *dev)
>  static void c_can_configure_msg_objects(struct net_device *dev)
>  {
>  	int i;
> +	struct c_can_priv *priv = netdev_priv(dev);
>  
>  	/* first invalidate all message objects */
>  	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_NO_OF_OBJECTS; i++)
>  		c_can_inval_msg_object(dev, 0, i);
>  
>  	/* setup receive message objects */
> -	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
> +	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST(priv); i++)
>  		c_can_setup_receive_object(dev, 0, i, 0, 0,
>  			(IF_MCONT_RXIE | IF_MCONT_UMASK) & ~IF_MCONT_EOB);
>  
> -	c_can_setup_receive_object(dev, 0, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
> +	c_can_setup_receive_object(dev, 0, C_CAN_MSG_OBJ_RX_LAST(priv), 0, 0,
>  			IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
>  }
>  
> @@ -745,8 +760,8 @@ static void c_can_do_tx(struct net_device *dev)
>  		msg_obj_no = get_tx_echo_msg_obj(priv);
>  		val = c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
>  		if (!(val & (1 << (msg_obj_no - 1)))) {
> -			can_get_echo_skb(dev,
> -					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
> +			can_get_echo_skb(dev, msg_obj_no - \
> +					get_msg_obj_tx_first(priv));
>  			stats->tx_bytes += priv->read_reg(priv,
>  					C_CAN_IFACE(MSGCTRL_REG, 0))
>  					& IF_MCONT_DLC_MASK;
> @@ -758,8 +773,8 @@ static void c_can_do_tx(struct net_device *dev)
>  	}
>  
>  	/* restart queue if wrap-up or if queue stalled on last pkt */
> -	if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) != 0) ||
> -			((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) == 0))
> +	if (((priv->tx_next & get_next_msg_obj_mask(priv)) != 0) ||
> +			((priv->tx_echo & get_next_msg_obj_mask(priv)) == 0))
>  		netif_wake_queue(dev);
>  }
>  
> @@ -770,19 +785,19 @@ static void c_can_do_tx(struct net_device *dev)
>   * object it finds free (starting with the lowest). Bits NEWDAT and
>   * INTPND are set for this message object indicating that a new message
>   * has arrived. To work-around this issue, we keep two groups of message
> - * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
> + * objects whose partitioning is defined by get_msg_obj_rx_split(priv).
>   *
>   * To ensure in-order frame reception we use the following
>   * approach while re-activating a message object to receive further
>   * frames:
>   * - if the current message object number is lower than
> - *   C_CAN_MSG_RX_LOW_LAST, do not clear the NEWDAT bit while clearing
> + *   get_msg_obj_rx_low_last(priv), do not clear the NEWDAT bit while clearing
>   *   the INTPND bit.
>   * - if the current message object number is equal to
> - *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of all lower
> + *   get_msg_obj_rx_low_last(priv) then clear the NEWDAT bit of all lower
>   *   receive message objects.
>   * - if the current message object number is greater than
> - *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of
> + *   get_msg_obj_rx_low_last(priv) then clear the NEWDAT bit of
>   *   only this message object.
>   */
>  static int c_can_do_rx_poll(struct net_device *dev, int quota)
> @@ -793,7 +808,7 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
>  	u32 val = c_can_read_reg32(priv, C_CAN_INTPND1_REG);
>  
>  	for (msg_obj = C_CAN_MSG_OBJ_RX_FIRST;
> -			msg_obj <= C_CAN_MSG_OBJ_RX_LAST && quota > 0;
> +			msg_obj <= C_CAN_MSG_OBJ_RX_LAST(priv) && quota > 0;
>  			val = c_can_read_reg32(priv, C_CAN_INTPND1_REG),
>  			msg_obj++) {
>  		/*
> @@ -822,14 +837,14 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
>  			/* read the data from the message object */
>  			c_can_read_msg_object(dev, 0, msg_ctrl_save);
>  
> -			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
> +			if (msg_obj < get_msg_obj_rx_low_last(priv))
>  				c_can_mark_rx_msg_obj(dev, 0,
>  						msg_ctrl_save, msg_obj);
> -			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
> +			else if (msg_obj > get_msg_obj_rx_low_last(priv))
>  				/* activate this msg obj */
>  				c_can_activate_rx_msg_obj(dev, 0,
>  						msg_ctrl_save, msg_obj);
> -			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST)
> +			else if (msg_obj == get_msg_obj_rx_low_last(priv))
>  				/* activate all lower message objects */
>  				c_can_activate_all_lower_rx_msg_obj(dev,
>  						0, msg_ctrl_save);
> @@ -1055,10 +1070,10 @@ static int c_can_poll(struct napi_struct *napi, int quota)
>  		if (lec_type)
>  			work_done += c_can_handle_bus_err(dev, lec_type);
>  	} else if ((irqstatus >= C_CAN_MSG_OBJ_RX_FIRST) &&
> -			(irqstatus <= C_CAN_MSG_OBJ_RX_LAST)) {
> +			(irqstatus <= C_CAN_MSG_OBJ_RX_LAST(priv))) {
>  		/* handle events corresponding to receive message objects */
>  		work_done += c_can_do_rx_poll(dev, (quota - work_done));
> -	} else if ((irqstatus >= C_CAN_MSG_OBJ_TX_FIRST) &&
> +	} else if ((irqstatus >= get_msg_obj_tx_first(priv)) &&
>  			(irqstatus <= C_CAN_MSG_OBJ_TX_LAST)) {
>  		/* handle events corresponding to transmit message objects */
>  		c_can_do_tx(dev);
> @@ -1146,17 +1161,18 @@ static int c_can_close(struct net_device *dev)
>  	return 0;
>  }
>  
> -struct net_device *alloc_c_can_dev(void)
> +struct net_device *alloc_c_can_dev(unsigned int tx_num)
>  {
>  	struct net_device *dev;
>  	struct c_can_priv *priv;
>  
> -	dev = alloc_candev(sizeof(struct c_can_priv), C_CAN_MSG_OBJ_TX_NUM);
> +	dev = alloc_candev(sizeof(struct c_can_priv), tx_num);
>  	if (!dev)
>  		return NULL;
>  
>  	priv = netdev_priv(dev);
> -	netif_napi_add(dev, &priv->napi, c_can_poll, C_CAN_NAPI_WEIGHT);
> +	netif_napi_add(dev, &priv->napi, c_can_poll, \
> +			(C_CAN_NO_OF_OBJECTS - tx_num));
>  
>  	priv->dev = dev;
>  	priv->can.bittiming_const = &c_can_bittiming_const;
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
> index d2e1c21..d5cd5d2 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -150,12 +150,26 @@ enum c_can_dev_id {
>  	BOSCH_D_CAN,
>  };
>  
> +/**
> + * struct c_can_platform_data - Depending on the underlying platform,
> + *                             the message object configuration
> + *                             for c_can controller can change
> + * @rx_split: defines the split point for the lower and upper Rx msg
> + *            object buckets.
> + * @tx_num: number of objs kept aside for TX purposes
> + */
> +struct c_can_platform_data {
> +	unsigned int rx_split;
> +	unsigned int tx_num;
> +};
> +
>  /* c_can private data structure */
>  struct c_can_priv {
>  	struct can_priv can;	/* must be the first member */
>  	struct napi_struct napi;
>  	struct net_device *dev;
>  	struct device *device;
> +	struct c_can_platform_data *pdata;
>  	int tx_object;
>  	int current_status;
>  	int last_status;
> @@ -174,7 +188,7 @@ struct c_can_priv {
>  	void (*raminit) (const struct c_can_priv *priv, bool enable);
>  };
>  
> -struct net_device *alloc_c_can_dev(void);
> +struct net_device *alloc_c_can_dev(unsigned int echo_count);
>  void free_c_can_dev(struct net_device *dev);
>  int register_c_can_dev(struct net_device *dev);
>  void unregister_c_can_dev(struct net_device *dev);
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> index 451e81f..6e8dc56 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -106,6 +106,25 @@ static const struct of_device_id c_can_of_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, c_can_of_table);
>  
> +#ifdef CONFIG_OF
> +static int __devinit c_can_probe_config_dt(struct platform_device *pdev,
> +					struct device_node *np)
> +{
> +	struct c_can_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +
> +	of_property_read_u32(np, "rx_split", &pdata->rx_split);
> +	of_property_read_u32(np, "tx_num", &pdata->tx_num);
> +
> +	return 0;
> +}
> +#else
> +static int __devinit c_can_probe_config_dt(struct platform_device *pdev,
> +		struct device_node *np)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
>  static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -114,6 +133,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  	struct c_can_priv *priv;
>  	const struct of_device_id *match;
>  	const struct platform_device_id *id;
> +	struct c_can_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct pinctrl *pinctrl;
>  	struct resource *mem, *res;
>  	int irq;
> @@ -129,12 +149,36 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  		}
>  		id = match->data;
>  
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		pdev->dev.platform_data = pdata;
> +		ret = c_can_probe_config_dt(pdev, pdev->dev.of_node);
> +
> +		if (ret) {
> +			dev_err(&pdev->dev, "Missing platform data\n");
> +			return -ENOSYS;
> +		} else if (!(pdata->rx_split && pdata->tx_num)) {
> +			dev_info(&pdev->dev,
> +					"invalid plat data, using default\n");
> +			pdata->rx_split = 9;
> +			pdata->tx_num = 16;
> +		}
> +
>  		if (of_property_read_u32(pdev->dev.of_node,
>  				"reg_alignment", &reg_alignment))
>  			dev_warn(&pdev->dev, "Register alignment not provided, \
>  					using 32-bit as default\n");
>  	} else {
>  		id = platform_get_device_id(pdev);
> +
> +		/*
> +		 * get the device specific details like Rx/Tx message object
> +		 * configurations from the platform data.
> +		 */
> +		pdata = pdev->dev.platform_data;
> +		if (!pdata) {
> +			dev_err(&pdev->dev, "platform data is NULL\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> @@ -176,7 +220,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  		reg_alignment = mem->flags;
>  
>  	/* allocate the c_can device */
> -	dev = alloc_c_can_dev();
> +	dev = alloc_c_can_dev(pdata->tx_num);
>  	if (!dev) {
>  		ret = -ENOMEM;
>  		goto exit_iounmap;
> @@ -186,6 +230,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  	switch (id->driver_data) {
>  	case BOSCH_C_CAN:
>  		priv->regs = reg_map_c_can;
> +		priv->pdata = pdata;
>  		switch (reg_alignment & IORESOURCE_MEM_TYPE_MASK) {
>  		case IORESOURCE_MEM_32BIT:
>  			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
> 

