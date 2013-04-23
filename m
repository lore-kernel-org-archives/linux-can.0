From: "Max S." <max@schneidersoft.net>
Subject: Usb to can driver
Date: Tue, 23 Apr 2013 17:15:02 +0000
Message-ID: <1366737302.3325.36.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XFVwgkZ71U0EQGXM7+iJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:52720 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642Ab3DWRUM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Apr 2013 13:20:12 -0400
Received: from [192.168.1.13] (unknown [179.163.88.251])
	by mail.schneidersoft.net (Postfix) with ESMTPSA id 5C3F41A17D
	for <linux-can@vger.kernel.org>; Tue, 23 Apr 2013 12:09:45 -0500 (CDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>


--=-XFVwgkZ71U0EQGXM7+iJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

I've been working on a device and a Linux socket can driver for it.

Its a dual USB to CAN adapter in two variants external USB device with
cable, or a mini pci form factor expansion card.

This is my first Linux driver, and I'd like to have someone look at it.
Feel free to criticize. I have not done any massive testing, but am able
to send and receive frames at 250k +full echo :). Higher speeds should
easily be possible, but i have not tested.

The firmware I have written myself. Here's how it enumerates:

$ lsusb -v -d beef:1234 # :P have yet to get proper USB vender code.

Bus 003 Device 003: ID beef:1234  
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0xbeef 
  idProduct          0x1234 
  bcdDevice            1.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 3 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0


Basic rundown of what the driver does now:
config information is passed between the host/device using the control
endpoint using brequest as a switch to indicate the command to run or
information requested.

Can frames are exchanged via bulk endpoints in a native format. meaning
a small header and a struct can_frame. The device is responsible for
packaging the can frame in a host readable format. when can frames
arrive, they are simply copied over by linux.

so:
1) When probed config data is exchanged between host and device.
indicating to the device what the 'host frame' format is, and what byte
order to use.
2) Two candevs are registered.

when an interface is brought up/configured:
3) settings are passed on to the device.
4) can controllers get initialized by the device.

When sending messages:
4) an echo id is associated with the frame, copied into the host frame
and sent to the device. bulk ep 2

When receiving messages:
5) data from bulk ep1 is received.
when echo_id == 0: this message was successfully received by the
controller. 
when echo_id != 0: this message was successfully sent by the controller.
echo_id for full echo support. 

Code attached,
Best regards,
Max S.

--=-XFVwgkZ71U0EQGXM7+iJ
Content-Disposition: attachment; filename="Makefile"
Content-Type: text/x-makefile; name="Makefile"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#called from kbuild system
ifneq ($(KERNELRELEASE),)
obj-m := ss_usb.o

#called from command line
else
KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

endif

#sudo modprobe pcan
#sudo modprobe candev
#sudo modprobe netconsole netconsole=6666@192.168.1.54/eth0,6666@192.168.1.39/aa:00:04:00:0a:04
#sudo insmod ss_usb.ko

--=-XFVwgkZ71U0EQGXM7+iJ
Content-Disposition: attachment; filename="ss_usb.c"
Content-Type: text/x-csrc; name="ss_usb.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <linux/init.h>
#include <linux/signal.h>
//#include <linux/slab.h>
//#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/netdevice.h>
#include <linux/usb.h>

#include <linux/can.h>
#include <linux/can/dev.h>
#include <linux/can/error.h>

/* Device specific constants */
#define USB_SSUSB_VENDOR_ID         0xbeef
#define USB_SSUSB_AT32_PRODUCT_ID   0x1234

#define SS_USB_ENDPOINT_IN          1
#define SS_USB_ENDPOINT_OUT         2

#define SS_USB_BREQ_HOST_FORMAT     0
#define SS_USB_BREQ_BITTIMING       1
#define SS_USB_BREQ_MODE            2
#define SS_USB_BREQ_BERR            3
#define SS_USB_BREQ_BT_CONST        4


#define SS_CAN_MODE_RESET           0
#define SS_CAN_MODE_START           1

#define SS_CAN_STATE_ERROR_ACTIVE   0
#define SS_CAN_STATE_ERROR_WARNING  1
#define SS_CAN_STATE_ERROR_PASSIVE  2
#define SS_CAN_STATE_BUS_OFF        3
#define SS_CAN_STATE_STOPPED        4
#define SS_CAN_STATE_SLEEPING       5

/* data types passed between host and device */
struct __packed device_config {
	u16 byte_order;

	u32 hf_size;	/* size of a host frame */
	u32 hf_can_id;
	u32 hf_can_dlc;
	u32 hf_data;
	u32 hf_echo_id;
	u32 hf_channel;
};

struct __packed device_mode {
	u8  mode;
};

struct __packed device_state {
	u8  state;
	u32 rxerr;
	u32 txerr;
};

struct __packed device_bittiming {
	u32 prop_seg;
	u32 phase_seg1;
	u32 phase_seg2;
	u32 sjw;
	u32 brp;
};

struct __packed device_bt_const {
	u32 fclk_can;
	u32 tseg1_min;
	u32 tseg1_max;
	u32 tseg2_min;
	u32 tseg2_max;
	u32 sjw_max;
	u32 brp_min;
	u32 brp_max;
	u32 brp_inc;
};

struct ss_host_frame {
	u8  channel;
	u32 echo_id;
	struct can_frame frame;
};

#define MAX_TX_URBS 10
#define MAX_RX_URBS 10

#define MAX_INTF 2

struct ss_tx_context {
	struct ss_can *dev;
	unsigned int echo_id;
};

struct ss_can {
	struct can_priv can; /* must be the first member */

	struct ss_usb *parent;

	struct net_device *netdev;
	struct usb_device *udev;
	struct usb_interface *iface;

	struct can_bittiming_const bt_const;
	unsigned int channel;	/* channel number */

	struct ss_tx_context tx_context[MAX_TX_URBS];

	struct usb_anchor tx_submitted;
	atomic_t active_tx_urbs;

	int open_time;
};

/* usb interface struct */
struct ss_usb {
//	struct usb_device *udev;
//	struct usb_interface *iface;

	struct ss_can *canch[MAX_INTF];

	struct usb_anchor rx_submitted;

	atomic_t active_channels;
};

/* 'allocate' a tx context.
 * returns a valid tx context or NULL if there is no space.
 */
static struct ss_tx_context *ss_alloc_tx_context( struct ss_can *dev )
{
	int ii=0;
	for(;ii<MAX_TX_URBS;ii++){
		if(dev->tx_context[ii].echo_id==MAX_TX_URBS){
			dev->tx_context[ii].echo_id=ii;
			return(&dev->tx_context[ii]);
		}
	}
	return NULL;
}

/* releases a tx context
 */
static void ss_free_tx_context(struct ss_tx_context *txc)
{
	txc->echo_id = MAX_TX_URBS;
}

/* Get a tx context by id. 
 */
static struct ss_tx_context *ss_get_tx_context( struct ss_can *dev, unsigned int id )
{
	if(id<MAX_TX_URBS){
		if(dev->tx_context[id].echo_id==id){
			return &dev->tx_context[id];
		}
	}

	return NULL;
}

/* Get a tx contexts id. 
 */
static unsigned int ss_tx_context_id( struct ss_tx_context *txc ){
	return(txc->echo_id);
}

#define BUFFER_SIZE sizeof(struct ss_host_frame)

/**************************** USB CALLBACKS **************************/
static void ss_usb_recieve_bulk_callback( struct urb *urb )
{
	struct ss_usb *usbcan = urb->context;
	struct ss_can *dev;
	struct net_device *netdev;
	int rc;
	struct net_device_stats *stats;
	struct sk_buff *skb;
	struct can_frame *cf;
	struct ss_host_frame *hf = urb->transfer_buffer;
	struct ss_tx_context *txc;

	BUG_ON(!usbcan);

	switch( urb->status ){
	case 0: /* success */
		break;
	case -ENOENT:
	case -ESHUTDOWN:
		return;
	default:
		printk(KERN_INFO "Rx URB aborted (%d)\n", urb->status);
		return;	//do not resubmit aborted urbs... happens when device goes down
		//goto resubmit_urb;
	}

	/* device reports out of range channel id */
	if(hf->channel>=MAX_INTF){
		printk(KERN_INFO "%d] strange channel #\n",hf->channel);
		goto resubmit_urb;
	}

	/* device reports bad channel id */
	dev = usbcan->canch[hf->channel];
	if( !dev )		//FIXME use assert instead
		goto resubmit_urb;

	netdev = dev->netdev;
	if( !netdev )		//FIXME use assert instead
		goto resubmit_urb;

	if( !netif_device_present(netdev) )
		return;

	stats = &dev->netdev->stats;

	if(hf->echo_id == 0){ /* normal */
		printk(KERN_INFO "%d] got msg\n",hf->channel);
		skb = alloc_can_skb(dev->netdev, &cf);
		if( skb==NULL )
			return;

		*cf = hf->frame;
		cf->can_dlc = get_can_dlc(hf->frame.can_dlc);

		netif_rx(skb);

		stats->rx_packets++;
		stats->rx_bytes += cf->can_dlc;
	}else{		/* echo_id = hf->echo_id-1 //echo ids start at 1 */
		txc = ss_get_tx_context(dev,hf->echo_id-1);

		/* bad devices send bad echo_ids. */
		if(!txc){
			printk(KERN_INFO "%d] bad echo %d\n",hf->channel,hf->echo_id);
			goto resubmit_urb;
		}else{
			printk(KERN_INFO "%d] got echo %d\n",hf->channel,hf->echo_id);
		}

		can_get_echo_skb(netdev, ss_tx_context_id(txc));

		ss_free_tx_context(txc);

		netdev->stats.tx_packets++;
//FIXME: report dlc
//		stats->tx_bytes += cf->can_dlc;

		netdev->trans_start = jiffies;

		if (netif_queue_stopped(netdev))
			netif_wake_queue(netdev);
	}


resubmit_urb:
//	do i really need to refill? the urb should still be valid
//	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, SS_USB_ENDPOINT_IN(dev->iface->altsetting[0].desc.bInterfaceNumber)), urb->transfer_buffer, BUFFER_SIZE, ss_usb_recieve_bulk_callback, dev);

	rc = usb_submit_urb(urb, GFP_ATOMIC);

	if( rc==-ENODEV )
		printk(KERN_INFO "resubmit error -ENODEV\n");
		//netif_device_detach(netdev);
	else if( rc )
		printk(KERN_INFO "resubmit error %d\n",rc);
}

static void ss_usb_xmit_callback( struct urb *urb )
{
	struct ss_tx_context *txc = urb->context;
	struct ss_can *dev;
	struct net_device *netdev;

	BUG_ON(!txc);

	dev = txc->dev;
	BUG_ON(!dev);

	netdev = dev->netdev;
	BUG_ON(!netdev);

	if (urb->status){
		printk(KERN_INFO "%d] xmit err %d\n",dev->channel,txc->echo_id+1);
	}else{
		printk(KERN_INFO "%d] xmit ok  %d\n",dev->channel,txc->echo_id+1);
	}

	usb_free_coherent(urb->dev, urb->transfer_buffer_length, urb->transfer_buffer, urb->transfer_dma);

	atomic_dec(&dev->active_tx_urbs);

	if (!netif_device_present(netdev))
		return;

	/* The urb never made it to the device. Drop this packet. */
	if (urb->status){
		dev_info(netdev->dev.parent, "Tx URB aborted (%d)\n", urb->status);
		can_free_echo_skb(netdev, ss_tx_context_id(txc));
		ss_free_tx_context(txc);
		netdev->stats.tx_dropped++;
	}

	if (netif_queue_stopped(netdev))
		netif_wake_queue(netdev);
}

/****************************** UBS CAN ******************************/
static int ss_usb_set_bittiming( struct net_device *netdev )
{
	struct ss_can *dev = netdev_priv(netdev);
	struct can_bittiming *bt = &dev->can.bittiming;
	struct usb_interface *intf = dev->iface;
	int rc;

	struct __packed device_bittiming dbt = {
		.prop_seg = bt->prop_seg,
		.phase_seg1 = bt->phase_seg1,
		.phase_seg2 = bt->phase_seg2,
		.sjw = bt->sjw,
		.brp = bt->brp
	};

	printk(KERN_INFO "CH: %d\n",dev->channel);
	printk(KERN_INFO "PRS %d\n",bt->prop_seg);
	printk(KERN_INFO "PH1 %d\n",bt->phase_seg1);
	printk(KERN_INFO "PH2 %d\n",bt->phase_seg2);
	printk(KERN_INFO "SJW %d\n",bt->sjw);
	printk(KERN_INFO "BRP %d\n",bt->brp);

	rc = usb_control_msg(interface_to_usbdev(intf),
			usb_sndctrlpipe(interface_to_usbdev(intf), 0),		/* pipe */
			SS_USB_BREQ_BITTIMING,					/* request */
			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,	/* request type */
			dev->channel,						/* value */
			0,							/* interface */
			&dbt,							/* data */
			sizeof(dbt),						/* len */
			1000);
	if(rc<0){
		dev_warn(netdev->dev.parent, "Couldn't set bittimings %d",rc);
	}

	return rc;
}

static int ss_usb_set_mode( struct net_device *netdev, enum can_mode mode )
{
	struct ss_can *dev = netdev_priv(netdev);
	struct usb_interface *intf = dev->iface;
	struct device_mode dm;
	int rc;
	printk(KERN_INFO "ss can mode %d\n",mode);

	if( !dev->open_time )
		return -EINVAL;


	switch( mode ){
	case CAN_MODE_START:
		dm.mode = SS_CAN_MODE_RESET;

		rc = usb_control_msg(interface_to_usbdev(intf),
				usb_sndctrlpipe(interface_to_usbdev(intf), 0),		/* pipe */
				SS_USB_BREQ_MODE,					/* request */
				USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,	/* request type */
				dev->channel,						/* value */
				0,							/* index */
				&dm,							/* data */
				sizeof(dm),						/* len */
				1000);
		if( rc<0 ){
			dev_warn(netdev->dev.parent, "Couldn't start device %d",rc);
			return rc;
		}

		if( netif_queue_stopped(netdev) )
			netif_wake_queue(netdev);
		break;
	case CAN_MODE_STOP:
	case CAN_MODE_SLEEP:
	default:
		return -EOPNOTSUPP;
	}

	return 0;
}

int ss_usb_get_state( const struct net_device *netdev, enum can_state *state )
{

	struct ss_can *dev = netdev_priv(netdev);
	struct usb_interface *intf = dev->iface;
	struct device_state dstate;
	int rc;
	printk(KERN_INFO "ss can state\n");

	rc = usb_control_msg(interface_to_usbdev(intf),
			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),		/* pipe */
			SS_USB_BREQ_BERR,					/* request */
			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,		/* request type */
			dev->channel,						/* value */
			0,							/* index */
			&dstate,						/* data */
			sizeof(dstate),						/* len */
			1000);
	if( rc<0 ){
		dev_warn(netdev->dev.parent, "Couldn't get state %d",rc);
		return rc;
	}

	printk(KERN_INFO "state: %d\n",dstate.state);

	switch(dstate.state){
		case SS_CAN_STATE_ERROR_ACTIVE:;
			*state = CAN_STATE_ERROR_ACTIVE;     /* RX/TX error count < 96 */
			return 0;
		case SS_CAN_STATE_ERROR_WARNING:;
			*state = CAN_STATE_ERROR_WARNING;    /* RX/TX error count < 128 */
			return 0;
		case SS_CAN_STATE_ERROR_PASSIVE:;
			*state = CAN_STATE_ERROR_PASSIVE;    /* RX/TX error count < 256 */
			return 0;
		case SS_CAN_STATE_BUS_OFF:;
			*state = CAN_STATE_BUS_OFF;          /* RX/TX error count >= 256 */
			return 0;
		case SS_CAN_STATE_STOPPED:;
			*state = CAN_STATE_STOPPED;          /* Device is stopped */
			return 0;
		case SS_CAN_STATE_SLEEPING:;
			*state = CAN_STATE_SLEEPING;         /* Device is sleeping */
			return 0;
	}

	return -ENOTSUPP;
}

static int ss_usb_get_berr_counter( const struct net_device *netdev, struct can_berr_counter *bec )
{
	struct ss_can *dev = netdev_priv(netdev);
	struct usb_interface *intf = dev->iface;
	struct device_state dstate;
	int rc;

	rc = usb_control_msg(interface_to_usbdev(intf),
			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),		/* pipe */
			SS_USB_BREQ_BERR,					/* request */
			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,		/* request type */
			dev->channel,						/* value */
			0,							/* index */
			&dstate,						/* data */
			sizeof(dstate),						/* len */
			1000);
	if( rc<0 ){
		dev_warn(netdev->dev.parent, "Couldn't get error counters %d",rc);
		return rc;
	}

	printk(KERN_INFO "txerr: %d rxerr: %d\n",dstate.txerr,dstate.rxerr);

	bec->txerr = dstate.txerr;
	bec->rxerr = dstate.rxerr;

	return 0;
}

static netdev_tx_t ss_can_start_xmit( struct sk_buff *skb, struct net_device *netdev )
{
	struct ss_can *dev = netdev_priv(netdev);
	struct net_device_stats *stats = &dev->netdev->stats;
	struct urb *urb;
	struct ss_host_frame *hf;
	int rc;
	struct ss_tx_context *txc;

	if (can_dropped_invalid_skb(netdev, skb))
		return NETDEV_TX_OK;

	/* find an empty context to keep track of transmission */
	txc = ss_alloc_tx_context(dev);
	if (!txc) {
		//dev_kfree_skb(skb);
		return NETDEV_TX_BUSY;
	}

	/* create a URB, and a buffer for it */
	urb = usb_alloc_urb(0, GFP_ATOMIC);
	if (!urb) {
		ss_free_tx_context(txc);
		dev_err(netdev->dev.parent, "No memory left for URBs\n");
		goto nomem;
	}

	hf = usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC, &urb->transfer_dma);
	if (!hf) {
		ss_free_tx_context(txc);
		dev_err(netdev->dev.parent, "No memory left for USB buffer\n");
		usb_free_urb(urb);
		goto nomem;
	}

	hf->frame = *(struct can_frame *)skb->data;
	hf->echo_id = ss_tx_context_id(txc)+1;
	hf->channel = dev->channel;

	usb_fill_bulk_urb(urb, dev->udev,
			usb_sndbulkpipe(dev->udev, SS_USB_ENDPOINT_OUT),
			hf,
			sizeof(*hf),
			ss_usb_xmit_callback,
			txc);

	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
	usb_anchor_urb(urb, &dev->tx_submitted);

	can_put_echo_skb(skb, netdev, ss_tx_context_id(txc));

	atomic_inc(&dev->active_tx_urbs);

//	printk(KERN_INFO "%d] xmit new %d\n",hf->channel,hf->echo_id);

	rc = usb_submit_urb(urb, GFP_ATOMIC);
	if (unlikely(rc)) {			// usb send failed

		printk(KERN_INFO "usb_submit failed %d\n",rc);

		can_free_echo_skb(netdev, ss_tx_context_id(txc));
		ss_free_tx_context(txc);

		usb_unanchor_urb(urb);
		usb_free_coherent(dev->udev, sizeof(*hf), hf, urb->transfer_dma);
		dev_kfree_skb(skb);

		atomic_dec(&dev->active_tx_urbs);

		if (rc == -ENODEV) {
			netif_device_detach(netdev);
		} else {
			dev_warn(netdev->dev.parent, "failed tx_urb %d\n", rc);

			stats->tx_dropped++;
		}
	} else {
		netdev->trans_start = jiffies;

		/* Slow down tx path */
		if (atomic_read(&dev->active_tx_urbs) >= MAX_TX_URBS ){
// || dev->free_slots < 5) {
			netif_stop_queue(netdev);
		}
	}

	/* let usb core take care of this urb */
	usb_free_urb(urb);

	return NETDEV_TX_OK;

nomem:
	dev_kfree_skb(skb);
	stats->tx_dropped++;
	return NETDEV_TX_OK;
}

static int ss_can_open( struct net_device *netdev )
{
	struct ss_can *dev = netdev_priv(netdev);
	struct ss_usb *parent = dev->parent;
	struct device_mode dm;
	int rc,i;

	/* common open */
	rc = open_candev(netdev);
	if( rc )
		return rc;

	if( atomic_add_return( 1, &parent->active_channels )==1 ){
		for( i = 0; i < MAX_RX_URBS; i++ ){
			struct urb *urb = NULL;
			u8 *buf = NULL;

			/* alloc rx urb */
			urb = usb_alloc_urb(0, GFP_KERNEL);
			if (!urb) {
				dev_err(netdev->dev.parent, "No memory left for URBs\n");
				return -ENOMEM;
			}

			/* alloc rx buffer */
			//FIXME: free this memory
			buf = usb_alloc_coherent(dev->udev, BUFFER_SIZE, GFP_KERNEL, &urb->transfer_dma);
			if (!buf) {
				dev_err(netdev->dev.parent,
					"No memory left for USB buffer\n");
				usb_free_urb(urb);
				return -ENOMEM;
			}


			/* fill, anchor, and submit rx urb */
			usb_fill_bulk_urb(urb,
					dev->udev,
					usb_rcvbulkpipe(dev->udev, SS_USB_ENDPOINT_IN),
					buf,
					BUFFER_SIZE,
					ss_usb_recieve_bulk_callback,
					parent
					);
			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

			usb_anchor_urb(urb, &parent->rx_submitted);

			rc = usb_submit_urb(urb, GFP_KERNEL);
			if( rc ){
				if( rc == -ENODEV )
					netif_device_detach( dev->netdev );

					//FIXME: free rx buffer/urb maybe?
					usb_unanchor_urb(urb);
				break;
			}

			/* Drop reference, USB core will take care of freeing it */
			usb_free_urb(urb);
		}
	}

	/* finally start device */
	dm.mode = SS_CAN_MODE_START;
	rc = usb_control_msg(interface_to_usbdev(dev->iface),
			usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),/* pipe */
			SS_USB_BREQ_MODE,					/* request */
			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,	/* request type */
			dev->channel,						/* value */
			0,							/* index */
			&dm,							/* data */
			sizeof(dm),						/* len */
			1000);

	if(rc<0){
		dev_warn(netdev->dev.parent, "Couldn't start device %d",rc);
	}

	dev->open_time = jiffies;

	netif_start_queue(netdev);

	printk(KERN_INFO "ss can open\n");
	return 0;
}

/* think: ip link set canx down */
static int ss_can_close( struct net_device *netdev )
{
	struct ss_can *dev = netdev_priv(netdev);
	struct ss_usb *parent = dev->parent;

	netif_stop_queue(netdev);

	/* Stop polling */
	if( atomic_dec_and_test( &parent->active_channels ) ){
		usb_kill_anchored_urbs(&parent->rx_submitted);
	//	foreach child
	//	usb_kill_anchored_urbs(&parent->tx_submitted);
		//CLEANUP OTHER
		/* Set CAN controller to reset mode */
	}

	close_candev(netdev);

	dev->open_time = 0;

	printk(KERN_INFO "ss can close\n");
	return 0;
}

/******************************** USB ********************************/

static const struct net_device_ops ss_usb_netdev_ops = {
	.ndo_open = ss_can_open,
	.ndo_stop = ss_can_close,
	.ndo_start_xmit = ss_can_start_xmit,
};

static int ss_make_candev( struct ss_can **dev, unsigned int channel, struct usb_interface *intf );
static void ss_destroy_candev( struct ss_can *dev );

static int ss_usb_probe( struct usb_interface *intf, const struct usb_device_id *id )
{
	struct ss_usb *dev;
	int rc = -ENOMEM;
	unsigned int icount,i;

	struct device_config conf;

	/* send host config */
	conf = (struct device_config){
		.byte_order = 0xbeef,
		.hf_size = sizeof(struct ss_host_frame),
		.hf_can_id = offsetof(struct ss_host_frame, frame.can_id),
		.hf_can_dlc = offsetof(struct ss_host_frame, frame.can_dlc),
		.hf_data = offsetof(struct ss_host_frame, frame.data),
		.hf_echo_id = offsetof(struct ss_host_frame, echo_id),
		.hf_channel = offsetof(struct ss_host_frame, channel),
	};

	rc = usb_control_msg(interface_to_usbdev(intf),
			usb_sndctrlpipe(interface_to_usbdev(intf), 0),		/* pipe */
			SS_USB_BREQ_HOST_FORMAT,				/* request */
			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,	/* request type */
			1,							/* value */
			intf->altsetting[0].desc.bInterfaceNumber,		/* index */
			&conf,							/* data */
			sizeof(conf),						/* len */
			1000);

	if( rc<0 ){
		dev_err(&intf->dev, "ss_usb: Couldn't send data format %d\n",rc);
		return rc;
	}

	/* fetch interface count and global settings etc.. */
	//TODO: --^
	icount = 2;

	if(icount>MAX_INTF){
		dev_err(&intf->dev, "ss_usb: Cannot handle more that %d Can interfaces\n",MAX_INTF);
		return -EINVAL;
	}

	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
	init_usb_anchor(&dev->rx_submitted);

	atomic_set(&dev->active_channels, 0);

	usb_set_intfdata(intf, dev);

	for(i=0;i<icount;i++){
		rc = ss_make_candev(&dev->canch[i],i,intf);
		if( rc ){
			icount = i;
			for(i=0;i<icount;i++){
				ss_destroy_candev(dev->canch[i]);
				dev->canch[icount] = NULL;
			}
			return rc;
		}
		dev->canch[i]->parent = dev;
	}

	printk(KERN_INFO "ss usb probe\n");
	return 0;
}

static void ss_usb_disconnect( struct usb_interface *intf )
{
	unsigned i;
	struct ss_usb *dev = usb_get_intfdata(intf);
	usb_set_intfdata(intf, NULL);

	if( !dev ){
		printk(KERN_INFO "ss usb disconnect (nodata)\n");
		return;
	}

	for(i=0;i<MAX_INTF;i++){
		struct ss_can *can=dev->canch[i];

		if(!can)
			continue;

		//ss_destroy_candev(dev->canch[i]);

		unregister_netdev(can->netdev);
		free_candev(can->netdev);

		usb_kill_anchored_urbs(&can->tx_submitted);

//		unlink_all_urbs(can->);

//		usb_free_urb(dev->intr_urb);
//		kfree(dev);
	}

	usb_kill_anchored_urbs(&dev->rx_submitted);

	printk(KERN_INFO "ss usb disconnect\n");
}

/******************* EVERYTHING BELLOW HERE WORKS! *******************/

MODULE_DEVICE_TABLE(usb, ss_usb_table);
static struct usb_device_id ss_usb_table[] = {
	{USB_DEVICE(USB_SSUSB_VENDOR_ID, USB_SSUSB_AT32_PRODUCT_ID)},
	{} /* Terminating entry */
};

static struct usb_driver ss_usb_driver = {
	.name       = "ss_usb",
	.probe      = ss_usb_probe,
	.disconnect = ss_usb_disconnect,
	.id_table   = ss_usb_table,
	//FIXME: suspend, resume, etc...
};

static int __init ss_usb_init( void )
{
	printk(KERN_INFO "ss usb init\n");
	return usb_register(&ss_usb_driver);
}

static void __exit ss_usb_exit( void )
{
	printk(KERN_INFO "ss usb exit\n");
	usb_deregister(&ss_usb_driver);
}

module_init(ss_usb_init);
module_exit(ss_usb_exit);

MODULE_AUTHOR("Maximilian Schneider <mws@schneidersoft.net>");
MODULE_DESCRIPTION("socket CAN device driver for SchneiderSoft USB2.0 to CAN interfaces.");
MODULE_LICENSE("GPL v2");





static int ss_make_candev( struct ss_can **out, unsigned int channel, struct usb_interface *intf )
{
	struct ss_can *dev;
	struct device_bt_const bt_const;
	struct net_device *netdev;
	int rc;
	/* fetch bit timing constants */
	rc = usb_control_msg(interface_to_usbdev(intf),
			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),		/* pipe */
			SS_USB_BREQ_BT_CONST,					/* request */
			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,		/* request type */
			channel,						/* value */
			0,							/* index */
			&bt_const,						/* data */
			sizeof(bt_const),					/* len */
			1000);

	if( rc<0 ){
		dev_err(&intf->dev, "ss_usb: Couldn't get bit timing const for channel %d\n",rc);
		return rc;
	}

	printk(KERN_INFO "fclock: %d\n",bt_const.fclk_can);

	/* create netdev */
	netdev = alloc_candev(sizeof(struct ss_can),MAX_TX_URBS);
	if( !netdev ){
		dev_err(&intf->dev, "ss_usb: Couldn't alloc candev\n");
		return -ENOMEM;
	}

	dev = netdev_priv(netdev);

	netdev->netdev_ops = &ss_usb_netdev_ops;
	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */

	/* dev settup */
	dev->bt_const = (struct can_bittiming_const){
		.name = "ss_usb",
		.tseg1_min = bt_const.tseg1_min,
		.tseg1_max = bt_const.tseg1_max,
		.tseg2_min = bt_const.tseg2_min,
		.tseg2_max = bt_const.tseg2_max,
		.sjw_max = bt_const.sjw_max,
		.brp_min = bt_const.brp_min,
		.brp_max = bt_const.brp_max,
		.brp_inc = bt_const.brp_inc
	};

	dev->udev = interface_to_usbdev(intf);
	dev->iface = intf;
	dev->netdev = netdev;
	dev->channel = channel;

	init_usb_anchor(&dev->tx_submitted);
	atomic_set(&dev->active_tx_urbs, 0);
	for(rc=0;rc<MAX_TX_URBS;rc++){
		dev->tx_context[rc].dev = dev;
		dev->tx_context[rc].echo_id = MAX_TX_URBS;
	}

	/* can settup */
	dev->can.state = CAN_STATE_STOPPED;
	dev->can.clock.freq = bt_const.fclk_can;
	dev->can.bittiming_const = &dev->bt_const;
	dev->can.do_set_bittiming = ss_usb_set_bittiming;
	dev->can.do_set_mode = ss_usb_set_mode;
	dev->can.do_get_state = ss_usb_get_state;
	dev->can.do_get_berr_counter = ss_usb_get_berr_counter;
	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;

	SET_NETDEV_DEV(netdev, &intf->dev);

	rc = register_candev(dev->netdev);
	if( rc ){
		free_candev(dev->netdev);
		dev_err(&intf->dev, "ss_usb: Couldn't register candev\n");
		return(rc);
	}

	*out = dev;
	return(0);
}

static void ss_destroy_candev( struct ss_can *dev )
{
	unregister_candev(dev->netdev);
	free_candev(dev->netdev);
}


--=-XFVwgkZ71U0EQGXM7+iJ--

