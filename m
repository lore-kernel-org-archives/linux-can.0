From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: How to send a CAN message while in a kernel module?
Date: Sun, 22 Mar 2020 19:47:55 +0100
Message-ID: <5edb635d-f248-6c79-766c-d818de52c229@hartkopp.net>
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
 <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
 <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
 <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:19996 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVSsH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 22 Mar 2020 14:48:07 -0400
In-Reply-To: <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Barrows <robb.barrows@gmail.com>
Cc: linux-can@vger.kernel.org



On 22/03/2020 19.03, Robert Barrows wrote:
> Thank you for all the direction Oliver,  I think I am on the correct path,
> but now have can_send returning with a "-1" (ERESTART). I used raw_sendmsg
> as a template for this and cut out (hopefully) unneeded code, but I am
> concerned I cut out something I needed.  Would you mind taking another look?

I would recommend to test your code with a virtual CAN (vcan0) first.

You should bring the system into the state that you can run

cangen vcan0

in one terminal and

candump vcan0

in another terminal and see some data there.

And then let your kernel module send on vcan0.

Running on a real CAN interface can have (wiring/termination) issue you 
would not like to debug when developing a kernel module ;-)

There's a problem with your code too:


> 
> Thanks.
> 
> int SendCanTime(struct timespec *tsCurrentTime) {
> 
>    struct sk_buff *skb;
>    struct can_frame *frame = kmalloc(sizeof (struct can_frame), GFP_KERNEL);

This creates a memory leak ...

Just use a static buffer:

struct can_frame frame;
struct can_frame *cf = &frame;


>    struct net_device *dev;
>    int err = 0;
>    int thetime = tsCurrentTime->tv_sec;
> 
>    // Set up can frame
>    frame->can_id = 0x00050F93 | CAN_EFF_FLAG;

cf->can_id = 0x00050F93 | CAN_EFF_FLAG;

>    frame->can_dlc = 6;

dito ...

>    frame->data[0] = 0x00;
>    frame->data[1] = 0x02;
>    memcpy(frame->data+2, &thetime, sizeof(int));
> 
>    // Find the netdevice named can0
>    read_lock(&dev_base_lock);
>    dev = first_net_device(&init_net);
>    while (!strcmp(dev->name, "can0")) {
>      printk(KERN_INFO "found [%s]\n", dev->name);
>      dev = next_net_device(dev);
>    }
>    read_unlock(&dev_base_lock);
> 
>    if (!dev)
>      return -ENXIO;
> 
>    // Create skb
>    skb = alloc_can_skb(dev, &frame);

skb = alloc_can_skb(dev, &cf);

I hope I made the pointer stuff correctly :-)

>    if (!skb)
>      goto put_dev;
> 
>    skb->dev = dev;
> 
>    err = can_send(skb, 0);
> 
>    dev_put(dev);
> 
>    if (err)
>      goto send_failed;
> 
>    return 0;
> 
> //kfree_skb(skb);
> put_dev:
>    dev_put(dev);
> send_failed:
>    return err;
> 
> }
>                                                                                 ^
> 
