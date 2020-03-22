From: Robert Barrows <robb.barrows@gmail.com>
Subject: Re: How to send a CAN message while in a kernel module?
Date: Sun, 22 Mar 2020 13:03:01 -0500
Message-ID: <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net> <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
 <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42282 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVSDO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 22 Mar 2020 14:03:14 -0400
Received: by mail-lj1-f182.google.com with SMTP id q19so11958568ljp.9
        for <linux-can@vger.kernel.org>; Sun, 22 Mar 2020 11:03:13 -0700 (PDT)
In-Reply-To: <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Thank you for all the direction Oliver,  I think I am on the correct path,
but now have can_send returning with a "-1" (ERESTART). I used raw_sendmsg
as a template for this and cut out (hopefully) unneeded code, but I am
concerned I cut out something I needed.  Would you mind taking another look?

Thanks.

int SendCanTime(struct timespec *tsCurrentTime) {

  struct sk_buff *skb;
  struct can_frame *frame = kmalloc(sizeof (struct can_frame), GFP_KERNEL);
  struct net_device *dev;
  int err = 0;
  int thetime = tsCurrentTime->tv_sec;

  // Set up can frame
  frame->can_id = 0x00050F93 | CAN_EFF_FLAG;
  frame->can_dlc = 6;
  frame->data[0] = 0x00;
  frame->data[1] = 0x02;
  memcpy(frame->data+2, &thetime, sizeof(int));

  // Find the netdevice named can0
  read_lock(&dev_base_lock);
  dev = first_net_device(&init_net);
  while (!strcmp(dev->name, "can0")) {
    printk(KERN_INFO "found [%s]\n", dev->name);
    dev = next_net_device(dev);
  }
  read_unlock(&dev_base_lock);

  if (!dev)
    return -ENXIO;

  // Create skb
  skb = alloc_can_skb(dev, &frame);
  if (!skb)
    goto put_dev;

  skb->dev = dev;

  err = can_send(skb, 0);

  dev_put(dev);

  if (err)
    goto send_failed;

  return 0;

//kfree_skb(skb);
put_dev:
  dev_put(dev);
send_failed:
  return err;

}
                                                                               ^
