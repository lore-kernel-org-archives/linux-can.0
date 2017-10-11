From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: check for null sk before deferencing it via the call
 to sock_net
Date: Wed, 11 Oct 2017 12:35:58 +0200
Message-ID: <9fe54aa3-5f40-7df7-3ff4-f104f18c0f02@hartkopp.net>
References: <20170908150235.2931-1-colin.king@canonical.com>
 <f5ce1047-eb37-151a-c7b7-9b47b70789f7@hartkopp.net>
 <CABATaM548q4dghmPgrh9qd7+q9Nq1UgA+ESXOrW+45gBWxdq3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:16794 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdJKKgS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Oct 2017 06:36:18 -0400
In-Reply-To: <CABATaM548q4dghmPgrh9qd7+q9Nq1UgA+ESXOrW+45gBWxdq3w@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chunyu Hu <chuhu.ncepu@gmail.com>, linux-can@vger.kernel.org, Colin King <colin.king@canonical.com>, =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>

Hi Marc,

this fix from Colin still didn't make it into upstream.

Can you please push it to Dave along with this one:
https://marc.info/?l=linux-can&m=150575760930022&w=2

Many thanks,
Oliver

On 10/11/2017 09:03 AM, Chunyu Hu wrote:
> I hit this oops in real world when running trinity test in ppc64le
> with a 4.14-rc3 kernel.
> 
> [  154.507777] NIP [d0000000065919fc] bcm_release+0x4c/0x320 [can_bcm]
> [  154.508300] LR [c000000000a0e070] sock_close+0x50/0x110
> [  154.508421] Call Trace:
> [  154.508481] [c0000001ebe93c20] [00000001fffffbf7] 0x1fffffbf7 (unreliable)
> [  154.508808] [c0000001ebe93cd0] [c000000000a0e070] sock_close+0x50/0x110
> [  154.509015] [c0000001ebe93d40] [c000000000438104] __fput+0xe4/0x2f0
> [  154.509168] [c0000001ebe93da0] [c000000000163790] task_work_run+0x140/0x1a0
> [  154.509320] [c0000001ebe93e00] [c00000000001e8a8]
> do_notify_resume+0x128/0x130
> [  154.509504] [c0000001ebe93e30] [c00000000000b5c4]
> ret_from_except_lite+0x70/0x74
> [  154.509702] Instruction dump:
> [  154.509793] fb61ffd8 fb81ffe0 fba1ffe8 fbc1fff0 fbe1fff8 f8010010
> f821ff51 7c791b78
> [  154.509978] 48000008 e8410018 ebb90020 2fbd0000 <eb9d0030> 419e0238
> 387d02d0 7fbeeb78
> 
> On 9 September 2017 at 01:46, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>>
>> On 09/08/2017 05:02 PM, Colin King wrote:
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The assignment of net via call sock_net will dereference sk. This
>>> is performed before a sanity null check on sk, so there could be
>>> a potential null dereference on the sock_net call if sk is null.
>>> Fix this by assigning net after the sk null check. Also replace
>>> the sk == NULL with the more usual !sk idiom.
>>>
>>> Detected by CoverityScan CID#1431862 ("Dereference before null check")
>>>
>>> Fixes: 384317ef4187 ("can: network namespace support for CAN_BCM
>>> protocol")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>>
>> Thanks Collin!
>>
>>
>>> ---
>>>    net/can/bcm.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>>> index 47a8748d953a..a3791674b8ce 100644
>>> --- a/net/can/bcm.c
>>> +++ b/net/can/bcm.c
>>> @@ -1493,13 +1493,14 @@ static int bcm_init(struct sock *sk)
>>>    static int bcm_release(struct socket *sock)
>>>    {
>>>          struct sock *sk = sock->sk;
>>> -       struct net *net = sock_net(sk);
>>> +       struct net *net;
>>>          struct bcm_sock *bo;
>>>          struct bcm_op *op, *next;
>>>    -     if (sk == NULL)
>>> +       if (!sk)
>>>                  return 0;
>>>    +     net = sock_net(sk);
>>>          bo = bcm_sk(sk);
>>>          /* remove bcm_ops, timer, rx_unregister(), etc. */
>>>
>>
