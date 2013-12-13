From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Fri, 13 Dec 2013 11:09:16 +0100
Message-ID: <55f73f8bda4d14c10394f50a69178b7f@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <f323c29b9730c877729322453b9e4ec9@grandegger.com>
 <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net>
 <85256584a266750b1330cfae8bebd55c@grandegger.com>
 <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com>
 <52892B21.9000501@grandegger.com>
 <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com>
 <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>
 <333c0fd4238558062478212eb0704b04@grandegger.com>
 <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com>
 <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com>
 <52A71B6C.3050600@hartkopp.net>
 <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com>
 <52A73BB1.7070701@hartkopp.net> <52A783B2.5020002@grandegger.com>
 <52A89A0A.7010803@hartkopp.net> <52A8BC94.6010805@grandegger.com>
 <52A953F3.3000605@hartkopp.net> <52A9F491.3060406@hartkopp.net>
 <52AA3F16.3070309@grandegger.com> <52AAD5A9.5030607@hartkopp.net>
 <56963612d7fd8d32efa0dc44dfc4593a@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:49205 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab3LMKJS (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 13 Dec 2013 05:09:18 -0500
In-Reply-To: <56963612d7fd8d32efa0dc44dfc4593a@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

Hi Oliver,



my mailer was too quick...



On Fri, 13 Dec 2013 11:04:42 +0100, Wolfgang Grandegger

<wg@grandegger.com> wrote:

> On Fri, 13 Dec 2013 10:38:49 +0100, Oliver Hartkopp

> <socketcan@hartkopp.net> wrote:

...

>> No idea ...

> 

> Try protecting note_interrupt() in irq_thread() as shown below:

> 

> raw_spin_unlock(&desc->lock);

>         if (!noirqdebug) {

> 

> 866                         note_interrupt(action->irq, desc,

action_ret);

> 



I mean modifying:



        if (!noirqdebug) {

               raw_spin_lock(&desc->lock);

               note_interrupt(action->irq, desc, action_ret);

               raw_spin_unlock(&desc->lock);

        }



here http://lxr.free-electrons.com/source/kernel/irq/manage.c#L865.



Maybe a normal spin_lock is already OK.



Wolfgang.


