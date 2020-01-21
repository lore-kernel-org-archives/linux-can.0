From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: general protection fault in can_rx_register
Date: Tue, 21 Jan 2020 20:28:51 +0100
Message-ID: <a04209c8-747b-6116-d915-21c285f48730@hartkopp.net>
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
 <20200121083035.GD14537@x1.vandijck-laurijssen.be>
 <20200121185407.GA13462@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200121185407.GA13462@x1.vandijck-laurijssen.be>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, o.rempel@pengutronix.de, syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
List-Id: linux-can.vger.kernel.org

Hi Kurt,

On 21/01/2020 19.54, Kurt Van Dijck wrote:
> On di, 21 jan 2020 09:30:35 +0100, Kurt Van Dijck wrote:
>> On ma, 20 jan 2020 23:35:16 +0100, Oliver Hartkopp wrote:


>>> But it is still open why dev->ml_priv is not set correctly in vxcan.c as all
>>> the settings for .priv_size and in vxcan_setup look fine.
>>
>> Maybe I got completely lost:
>> Shouldn't can_ml_priv and vxcan_priv not be similar?
>> Where is the dev_rcv_lists in the vxcan case?
> 
> I indeed got completely lost. vxcan_priv & can_ml_priv form together the
> private part. I continue looking

I added some more debug output:

@@ -463,6 +463,10 @@ int can_rx_register(struct net *net, struct 
net_device *dev, canid_t can_id,
         spin_lock_bh(&net->can.rcvlists_lock);

         dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+       if (!dev_rcv_lists) {
+               pr_err("dev_rcv_lists == NULL! %p (%s)\n", dev, dev->name);
+               goto out_unlock;
+       }
         rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);

         rcv->can_id = can_id;


and the output becomes:

[ 1814.644087] bond5130: (slave vxcan1): The slave device specified does 
not support setting the MAC address
[ 1814.644106] bond5130: (slave vxcan1): Error -22 calling dev_set_mtu
[ 1814.648867] bond5128: (slave vxcan1): The slave device specified does 
not support setting the MAC address
[ 1814.648904] bond5128: (slave vxcan1): Error -22 calling dev_set_mtu
[ 1814.649124] dev_rcv_lists == NULL! 000000008e41fb06 (bond5128)
[ 1814.696420] bond5129: (slave vxcan1): The slave device specified does 
not support setting the MAC address
[ 1814.696438] bond5129: (slave vxcan1): Error -22 calling dev_set_mtu

So it's not the vxcan1 netdev that causes the issue but (sporadically!!) 
the bonding netdev.

Interesting enough that the bonding device bond5128 obviously passes the

        if (dev && dev->type != ARPHRD_CAN)
                 return -ENODEV;
test.

?!?

Regards,
Oliver
