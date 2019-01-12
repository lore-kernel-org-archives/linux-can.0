From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: UBSAN: Undefined behaviour in net/can/bcm.c
Date: Sat, 12 Jan 2019 21:02:43 +0100
Message-ID: <c3a95ad5-5eae-6392-f263-9f05e7f51333@hartkopp.net>
References: <CAEAjamvf8LzpRauFhxeh-EGY_ttqeds6_UQwikc5sm7ORKdjjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAEAjamvf8LzpRauFhxeh-EGY_ttqeds6_UQwikc5sm7ORKdjjw@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Kyungtae Kim <kt0755@gmail.com>, davem@davemloft.net, Arnd Bergmann <arnd@arndb.de>
Cc: mkl@pengutronix.de, Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong <threeearcat@gmail.com>, syzkaller@googlegroups.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi,

thanks for the report!

On 1/12/19 8:25 PM, Kyungtae Kim wrote:
> We report a bug in linux-4.19.13: "UBSAN: Undefined behaviour in net/can/bcm.c"
> 
> kernel config: https://kt0755.github.io/etc/config_4.19.13
> repro: https://kt0755.github.io/etc/repro.296b5.c
> 
> An integer overflow arose in bcm_timeval_to_ktime() when
> tv.tv_usec * NSEC_PER_USEC is larger than its boundary of the
> destination (i.e., long).
> To fix, an appropriate boundary check should be placed right before the usage.

Just checked the commit that introduced the issue:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba61a8d9d7809

In fact the tv.tv_usec needs to be checked to be smaller than 1000*1000 
before multiplying with 1000 (NSEC_PER_USEC).

The code in question

static inline ktime_t bcm_timeval_to_ktime(struct bcm_timeval tv)
{
        return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
}

is a 1:1 copy of the standard function in ktime.h

/* convert a timeval to ktime_t format: */
static inline ktime_t timeval_to_ktime(struct timeval tv)
{
	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
}

https://elixir.bootlin.com/linux/v4.20.1/source/include/linux/ktime.h#L81

And therefore I thought it was a good choice ;-)

So there could potentially be some other users of timeval_to_ktime() 
that might have the same issue.

Will provide a check in bcm.c in rx_setup and tx_setup as the timeval 
content can be provided from user space there.

@Arnd: Do you have a better idea?

Thanks & best regards,
Oliver

> =========================================
> UBSAN: Undefined behaviour in net/can/bcm.c:140:41
> signed integer overflow:
> 60870466536963773 * 1000 cannot be represented in type 'long int'
> CPU: 0 PID: 7063 Comm: syz-executor3 Not tainted 4.19.13 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xd2/0x148 lib/dump_stack.c:113
>   ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
>   handle_overflow+0x1cf/0x21a lib/ubsan.c:190
>   __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
>   bcm_timeval_to_ktime net/can/bcm.c:140 [inline]
>   bcm_rx_setup net/can/bcm.c:1190 [inline]
>   bcm_sendmsg+0x3807/0x3fd0 net/can/bcm.c:1355
>   sock_sendmsg_nosec net/socket.c:621 [inline]
>   sock_sendmsg+0xdd/0x130 net/socket.c:631
>   sock_write_iter+0x24b/0x3d0 net/socket.c:900
>   call_write_iter include/linux/fs.h:1811 [inline]
>   new_sync_write fs/read_write.c:474 [inline]
>   __vfs_write+0x538/0x6e0 fs/read_write.c:487
>   vfs_write+0x1b3/0x520 fs/read_write.c:549
>   ksys_write+0xde/0x1c0 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
>   do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4497b9
> Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fc2e6feac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fc2e6feb6cc RCX: 00000000004497b9
> RDX: 0000000000000048 RSI: 00000000200000c0 RDI: 0000000000000013
> RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000ba60 R14: 00000000006f4b00 R15: 00007fc2e6feb700
> =========================================
> 
> Thanks,
> Kyungtae Kim
> 
