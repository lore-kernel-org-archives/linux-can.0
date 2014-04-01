From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: c_can: wrong frame order reception
Date: Tue, 01 Apr 2014 20:33:30 +0200
Message-ID: <533B067A.3030609@hartkopp.net>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:58897 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaDASdh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 14:33:37 -0400
In-Reply-To: <7234338.9RqiOdiLOY@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Alexander,

don't know if you monitored the patch set which was posted by Thomas Gleixner:

There was one patch "c_can: Make it SMP safe"

	http://marc.info/?l=linux-can&m=139516364829052&w=2

which addressed some issues, you obviously fixed with your below patch too.

Your patch below additionally implements the PCH_CAN support for C_CAN.

Can you please check, if the patchset from Thomas which is available here

	tag 'linux-can-fixes-for-3.15-20140401'
	in https://gitorious.org/linux-can/linux-can

fixes the frame order reception in your setup too - and if so, sent a rebased
patch for the PCH_CAN support?

Unfortunately I don't have a eg20t here :-]

Many thanks,
Oliver


On 05.03.2014 16:13, Alexander Stein wrote:
> On Wednesday 05 March 2014 15:58:09, Alexander Stein wrote:
>> [...]
> 
> Forgot the patches...
> 
> commit 166f18484b0b21eed04204926e82ec244942517e
> Author: Alexander Stein <alexander.stein@systec-electronic.com>
> Date:   Tue Feb 25 16:52:27 2014 +0100
> 
>     c_can: Add support for eg20t (pch_can)
>     
>     Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index e59c42b..e761d06 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -34,6 +34,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
>  #include <linux/pm_runtime.h>
>  
>  #include <linux/can.h>
> @@ -159,6 +160,10 @@
>  #define C_CAN_NEXT_MSG_OBJ_MASK	(C_CAN_MSG_OBJ_TX_NUM - 1)
>  #define RECEIVE_OBJECT_BITS	0x0000ffff
>  
> +/* message interface used for rx and tx */
> +#define IFACE_RX		0
> +#define IFACE_TX		1
> +
>  /* status interrupt */
>  #define STATUS_INTERRUPT	0x8000
>  
> @@ -544,14 +549,17 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>  	u32 msg_obj_no;
>  	struct c_can_priv *priv = netdev_priv(dev);
>  	struct can_frame *frame = (struct can_frame *)skb->data;
> +	unsigned long flags;
>  
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
>  
> +	spin_lock_irqsave(&priv->lock, flags);
> +
>  	msg_obj_no = get_tx_next_msg_obj(priv);
>  
>  	/* prepare message object for transmission */
> -	c_can_write_msg_object(dev, 0, frame, msg_obj_no);
> +	c_can_write_msg_object(dev, IFACE_TX, frame, msg_obj_no);
>  	can_put_echo_skb(skb, dev, msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
>  
>  	/*
> @@ -563,6 +571,8 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>  			(priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) == 0)
>  		netif_stop_queue(dev);
>  
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
>  	return NETDEV_TX_OK;
>  }
>  
> @@ -613,16 +623,18 @@ static void c_can_configure_msg_objects(struct net_device *dev)
>  	int i;
>  
>  	/* first invalidate all message objects */
> -	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_NO_OF_OBJECTS; i++)
> -		c_can_inval_msg_object(dev, 0, i);
> +	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_OBJ_RX_LAST; i++)
> +		c_can_inval_msg_object(dev, IFACE_RX, i);
> +	for (i = C_CAN_MSG_OBJ_TX_FIRST; i <= C_CAN_MSG_OBJ_TX_LAST; i++)
> +		c_can_inval_msg_object(dev, IFACE_TX, i);
>  
>  	/* setup receive message objects */
>  	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
> -		c_can_setup_receive_object(dev, 0, i, 0, 0,
> +		c_can_setup_receive_object(dev, IFACE_RX, i, 0, 0,
>  			(IF_MCONT_RXIE | IF_MCONT_UMASK) & ~IF_MCONT_EOB);
>  
> -	c_can_setup_receive_object(dev, 0, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
> -			IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
> +	c_can_setup_receive_object(dev, IFACE_RX, C_CAN_MSG_OBJ_RX_LAST,
> +			0, 0, IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
>  }
>  
>  /*
> @@ -756,6 +768,9 @@ static void c_can_do_tx(struct net_device *dev)
>  	u32 msg_obj_no;
>  	struct c_can_priv *priv = netdev_priv(dev);
>  	struct net_device_stats *stats = &dev->stats;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
>  
>  	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
>  		msg_obj_no = get_tx_echo_msg_obj(priv);
> @@ -764,11 +779,11 @@ static void c_can_do_tx(struct net_device *dev)
>  			can_get_echo_skb(dev,
>  					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
>  			stats->tx_bytes += priv->read_reg(priv,
> -					C_CAN_IFACE(MSGCTRL_REG, 0))
> +					C_CAN_IFACE(MSGCTRL_REG, IFACE_TX))
>  					& IF_MCONT_DLC_MASK;
>  			stats->tx_packets++;
>  			can_led_event(dev, CAN_LED_EVENT_TX);
> -			c_can_inval_msg_object(dev, 0, msg_obj_no);
> +			c_can_inval_msg_object(dev, IFACE_TX, msg_obj_no);
>  		} else {
>  			break;
>  		}
> @@ -778,6 +793,8 @@ static void c_can_do_tx(struct net_device *dev)
>  	if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) != 0) ||
>  			((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) == 0))
>  		netif_wake_queue(dev);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
>  }
>  
>  /*
> @@ -818,13 +835,14 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
>  		 * message object n, we need to handle the same properly.
>  		 */
>  		if (val & (1 << (msg_obj - 1))) {
> -			c_can_object_get(dev, 0, msg_obj, IF_COMM_ALL &
> +			c_can_object_get(dev, IFACE_RX, msg_obj, IF_COMM_ALL &
>  					~IF_COMM_TXRQST);
>  			msg_ctrl_save = priv->read_reg(priv,
> -					C_CAN_IFACE(MSGCTRL_REG, 0));
> +					C_CAN_IFACE(MSGCTRL_REG, IFACE_RX));
>  
>  			if (msg_ctrl_save & IF_MCONT_MSGLST) {
> -				c_can_handle_lost_msg_obj(dev, 0, msg_obj);
> +				c_can_handle_lost_msg_obj(dev, IFACE_RX,
> +								msg_obj);
>  				num_rx_pkts++;
>  				quota--;
>  				continue;
> @@ -837,19 +855,19 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
>  				continue;
>  
>  			/* read the data from the message object */
> -			c_can_read_msg_object(dev, 0, msg_ctrl_save);
> +			c_can_read_msg_object(dev, IFACE_RX, msg_ctrl_save);
>  
>  			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
> -				c_can_mark_rx_msg_obj(dev, 0,
> +				c_can_mark_rx_msg_obj(dev, IFACE_RX,
>  						msg_ctrl_save, msg_obj);
>  			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
>  				/* activate this msg obj */
> -				c_can_activate_rx_msg_obj(dev, 0,
> +				c_can_activate_rx_msg_obj(dev, IFACE_RX,
>  						msg_ctrl_save, msg_obj);
>  			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST)
>  				/* activate all lower message objects */
>  				c_can_activate_all_lower_rx_msg_obj(dev,
> -						0, msg_ctrl_save);
> +						IFACE_RX, msg_ctrl_save);
>  
>  			num_rx_pkts++;
>  			quota--;
> @@ -1187,6 +1205,8 @@ struct net_device *alloc_c_can_dev(void)
>  					CAN_CTRLMODE_LISTENONLY |
>  					CAN_CTRLMODE_BERR_REPORTING;
>  
> +	spin_lock_init(&priv->lock);
> +
>  	return dev;
>  }
>  EXPORT_SYMBOL_GPL(alloc_c_can_dev);
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
> index d2e1c21..6e7715e 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -172,6 +172,7 @@ struct c_can_priv {
>  	u32 __iomem *raminit_ctrlreg;
>  	unsigned int instance;
>  	void (*raminit) (const struct c_can_priv *priv, bool enable);
> +	spinlock_t lock;	/* to protect tx and rx message objects */
>  };
>  
>  struct net_device *alloc_c_can_dev(void);
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
> index b374be7..bc31d7f 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -19,9 +19,13 @@
>  
>  #include "c_can.h"
>  
> +#define PCI_DEVICE_ID_PCH_CAN	0x8818
> +#define PCH_PCI_SOFT_RESET	0x01fc
> +
>  enum c_can_pci_reg_align {
>  	C_CAN_REG_ALIGN_16,
>  	C_CAN_REG_ALIGN_32,
> +	C_CAN_REG_32,
>  };
>  
>  struct c_can_pci_data {
> @@ -31,6 +35,10 @@ struct c_can_pci_data {
>  	enum c_can_pci_reg_align reg_align;
>  	/* Set the frequency */
>  	unsigned int freq;
> +	/* PCI bar number */
> +	int bar;
> +	/* Callback for reset */
> +	void (*init) (const struct c_can_priv *priv, bool enable);
>  };
>  
>  /*
> @@ -63,6 +71,29 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
>  	writew(val, priv->base + 2 * priv->regs[index]);
>  }
>  
> +static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
> +				    enum reg index)
> +{
> +	return (u16)ioread32(priv->base + 2 * priv->regs[index]);
> +}
> +
> +static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
> +				      enum reg index, u16 val)
> +{
> +	iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
> +}
> +
> +static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)
> +{
> +	if (enable) {
> +		u32 __iomem *addr = priv->base + PCH_PCI_SOFT_RESET;
> +
> +		/* write to sw reset register */
> +		iowrite32(1, addr);
> +		iowrite32(0, addr);
> +	}
> +}
> +
>  static int c_can_pci_probe(struct pci_dev *pdev,
>  			   const struct pci_device_id *ent)
>  {
> @@ -87,7 +118,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,
>  	pci_set_master(pdev);
>  	pci_enable_msi(pdev);
>  
> -	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +	addr = pci_iomap(pdev, c_can_pci_data->bar, pci_resource_len(pdev, 0));
>  	if (!addr) {
>  		dev_err(&pdev->dev,
>  			"device has no PCI memory resources, "
> @@ -142,11 +173,17 @@ static int c_can_pci_probe(struct pci_dev *pdev,
>  		priv->read_reg = c_can_pci_read_reg_aligned_to_16bit;
>  		priv->write_reg = c_can_pci_write_reg_aligned_to_16bit;
>  		break;
> +	case C_CAN_REG_32:
> +		priv->read_reg = c_can_pci_read_reg_32bit;
> +		priv->write_reg = c_can_pci_write_reg_32bit;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		goto out_free_c_can;
>  	}
>  
> +	priv->raminit = c_can_pci_data->init;
> +
>  	ret = register_c_can_dev(dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
> @@ -195,6 +232,15 @@ static struct c_can_pci_data c_can_sta2x11= {
>  	.type = BOSCH_C_CAN,
>  	.reg_align = C_CAN_REG_ALIGN_32,
>  	.freq = 52000000, /* 52 Mhz */
> +	.bar = 0,
> +};
> +
> +static struct c_can_pci_data c_can_pch = {
> +	.type = BOSCH_C_CAN,
> +	.reg_align = C_CAN_REG_32,
> +	.freq = 50000000, /* 50 MHz */
> +	.init = c_can_pci_reset_pch,
> +	.bar = 1,
>  };
>  
>  #define C_CAN_ID(_vend, _dev, _driverdata) {		\
> @@ -204,6 +250,8 @@ static struct c_can_pci_data c_can_sta2x11= {
>  static DEFINE_PCI_DEVICE_TABLE(c_can_pci_tbl) = {
>  	C_CAN_ID(PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_CAN,
>  		 c_can_sta2x11),
> +	C_CAN_ID(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PCH_CAN,
> +		 c_can_pch),
>  	{},
>  };
>  static struct pci_driver c_can_pci_driver = {
> 
> 
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index e761d06..5d1cab7 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -477,6 +477,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
>  			frame->data[i + 1] = data >> 8;
>  		}
>  	}
> +	netdev_info(dev, "0x%03x %02x %02x\n", frame->can_id, frame->data[2], frame->data[3]);
>  
>  	netif_receive_skb(skb);
>  
> @@ -864,10 +865,13 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
>  				/* activate this msg obj */
>  				c_can_activate_rx_msg_obj(dev, IFACE_RX,
>  						msg_ctrl_save, msg_obj);
> +			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST) {
>  			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST)
>  				/* activate all lower message objects */
>  				c_can_activate_all_lower_rx_msg_obj(dev,
>  						IFACE_RX, msg_ctrl_save);
> +				netdev_info(dev, "free lower\n");
> +			}
>  
>  			num_rx_pkts++;
>  			quota--;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
