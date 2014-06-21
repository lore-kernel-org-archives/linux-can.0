From: Luis de Arquer <ldearquer@gmail.com>
Subject: Kvaser lapcan driver (init and probe)
Date: Sat, 21 Jun 2014 14:51:13 +0100
Message-ID: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f195.google.com ([209.85.216.195]:58324 "EHLO
	mail-qc0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbaFUNvO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Jun 2014 09:51:14 -0400
Received: by mail-qc0-f195.google.com with SMTP id o8so1576153qcw.6
        for <linux-can@vger.kernel.org>; Sat, 21 Jun 2014 06:51:13 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

We have some Kvaser Lapcan PCMCIA cards at work which I found are not
supported for linux -there is an old driver, but it is not compatible
with current pcmcia subsystem and is not socketcan either.

Based on the old driver I have started making a new SocketCAN driver.
I know this is a bit old technology, but we still have quite a few
laptops with pcmcia sockets, and they may still be around for some
years.

I am posting what I have done so far in case someone could have a
look. I had done small modules before, but this is the first time I
post upstream.
What I am bringing here is only the pcmcia bit, which maybe should be
posted somewhere else, but I could not find a pcmcia specific mailing
list. Also, it will eventually be a SocketCAN driver, so I though it
might be OK here.

I have a few questions, a reply any of them is very welcome.

1- This is just an incomplete part of a driver. Should it be emailed
with a "[PATCH]" subject and using diff? I have not done it because,
as a patch on itself, it is quite useless.

2- What is the counterpart of 'pcmcia_request_io()'? There seems to be
a 'pcmcia_release_io()', but it is not accessible. It is internally
called by 'pcmcia_disable_device()', but 'pcmcia_disable_device()' is,
on itself, the counterpart for 'pcmcia_enable_device()'. So, what is
the right thing to do if 'pcmcia_request_io()' succeeds, but
'pcmcia_enable_device()' fails?

3- I am requesting the IRQ *after* the call to
'pcmcia_enable_device()' -as seen in the peak_pcmcia driver. Would it
be better to do it before?

Thanks
Luis


#include <linux/init.h>
#include <linux/module.h>
#include <linux/device.h>
#include <pcmcia/device_id.h>
#include <pcmcia/cistpl.h>
#include <pcmcia/ds.h>


MODULE_LICENSE("GPL");


static struct pcmcia_device_id lapcan_table[] = {
    PCMCIA_DEVICE_MANF_CARD(0x01EE, 0x001D),
    PCMCIA_DEVICE_NULL,
};

MODULE_DEVICE_TABLE(pcmcia, lapcan_table);


struct lapcan_card {
    int res_count;
    struct pcmcia_device *pdev;
    unsigned int base_address;
};


static irqreturn_t lapcan_isr(int irq, void *dev_id)
{
    return IRQ_HANDLED;
}


/* This callback is only used for debug at the moment */
static int lapcan_conf_check(struct pcmcia_device *pdev, void *priv_data)
{
    struct lapcan_card *card = (struct lapcan_card*) priv_data;
    int i;

    /* Print debug information and return */
    card->res_count++;
    dev_dbg(&pdev->dev, "res_count = %d", card->res_count);
    for(i=0; i<6; i++)
    {
        if(pdev->resource[i]->flags & IORESOURCE_IO)
        {
            dev_dbg(&pdev->dev, " > IO resource: %d start: %lld end: %lld",
                i, pdev->resource[i]->start, pdev->resource[i]->end);
        }
        if(pdev->resource[i]->flags & IORESOURCE_MEM)
        {
            dev_dbg(&pdev->dev, " > MEM resource: %d start: %lld end: %lld",
                i, pdev->resource[i]->start, pdev->resource[i]->end);
        }
    }

    dev_dbg(&pdev->dev, "Number of I/O lines: %d", pdev->io_lines);

    return 0;
}


static int lapcan_probe(struct pcmcia_device *pdev)
{
    struct lapcan_card *card;
    int err;

    dev_dbg(&pdev->dev, "probing");

    card = kzalloc(sizeof(struct lapcan_card), GFP_KERNEL);
    if (!card) {
        err = -ENOMEM;
        goto probe_err_0;
    }

    card->res_count = 0;
    pdev->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;

    err = pcmcia_loop_config(pdev, lapcan_conf_check, card);
    if (err) {
        dev_err(&pdev->dev, "pcmcia_loop_config() error %d\n", err);
        goto probe_err_1;
    }

    /* Check configuration: we expect 1 IRQ and 8 I/O ports */
    if (!pdev->irq) {
        dev_err(&pdev->dev, "no irq assigned\n");
        err = -ENODEV;
        goto probe_err_1;
    }

    if (pdev->resource[0]->end != 8) {
        dev_err(&pdev->dev, "unexpected number of I/O ports: %lld\n",
                        pdev->resource[0]->end);
        err = -ENODEV;
        goto probe_err_1;
    }

    /* Request I/O (how to undo this call if next step fails?) */
    err = pcmcia_request_io(pdev);
    if(err) {
        dev_err(&pdev->dev, "pcmcia_request_io failed err=%d\n", err);
        goto probe_err_1;
    }

    card->base_address = pdev->resource[0]->start;

    /* Enable device */
    err = pcmcia_enable_device(pdev);
    if (err) {
        dev_err(&pdev->dev, "pcmcia_enable_device failed err=%d\n", err);
        goto probe_err_2;
    }

    card->pdev = pdev;
    pdev->priv = card;

    /* Request IRQ (should be before pcmcia_enable_device?) */
    err = request_irq(pdev->irq, &lapcan_isr, IRQF_SHARED, "lapcan", card);
    if (err) {
        dev_err(&pdev->dev, "couldn't request irq%d\n", pdev->irq);
        goto probe_err_2;
    }

    /* Is this needed? */
    pdev->_irq = 1;
    pdev->_locked = 1;

    return 0;


probe_err_2:
    pcmcia_disable_device(pdev);

probe_err_1:
    kfree(card);
    pdev->priv = NULL;

probe_err_0:
    return err;
}



/*
 * release claimed resources
 */
static void lapcan_remove(struct pcmcia_device *pdev)
{
    struct lapcan_pccard *card = pdev->priv;

    dev_info(&pdev->dev, "device removed");

    free_irq(pdev->irq, card);
    pcmcia_disable_device(pdev);

    if (!card)
        return;

    kfree(card);
    pdev->priv = NULL;
}

static struct pcmcia_driver lapcan_driver = {
    .name = "lapcan",
    .probe = lapcan_probe,
    .remove = lapcan_remove,
    .id_table = lapcan_table,
};

static int __init lapcan_init(void)
{
    printk(KERN_ALERT "lapcan: init");
    return pcmcia_register_driver(&(lapcan_driver));
}


static void __exit lapcan_exit(void)
{
    printk(KERN_ALERT "lapcan: exit");
    pcmcia_unregister_driver(&(lapcan_driver));
}

module_init(lapcan_init);
module_exit(lapcan_exit);
