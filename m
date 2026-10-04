Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B13009F6
	for <linux-can@vger.kernel.org>; Sun,  4 Oct 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114283; cv=none; b=cV/G3bJFtnx/Wf9cfJ1skSBYW1RvgOkoxtdVQHvUUShMiiQ1Mzi41Eu43wKzkgGluVVPjynIYse/ofojdo+wSoO12f1xLVyXxXByOa2r4oLMG7ORdE0CTcgjt9Tmxnw6IQK3sdPyReE0/SZQpNR3Oyn2Cn5ARfBHaosCLJLseBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114283; c=relaxed/simple;
	bh=lX0X8BaX72urDaVdrPYg598wh6mW2sk2Rkrif1pZ/Is=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=LZFfqgb9xLIqGdpFqmYAbZ18zNXs9wCv9OIMGNBFm3WpWs/mHVq7GRL/z5JiUx7k1xTUhhzAoqFwBzmDQBNOnwy2I+igefBuw5psad6Qz2iqLJJL8VbFnf1h5YDu+ReJ+wzKOyao6ix07cLUmm/PIBxBMEdZi4yaMpT7bgbukZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 694BiMIT076113;
	Sun, 4 Oct 2026 20:44:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 694BiM6Z076110
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 4 Oct 2026 20:44:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Content-Type: multipart/mixed; boundary="------------9av9CEdamI3OzCLPoQ2BROxe"
Message-ID: <c58c0c97-d3fd-4589-bb21-a0752be96866@I-love.SAKURA.ne.jp>
Date: Sun, 4 Oct 2026 20:44:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu leak
 when re-bind failed
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
        syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-7-mkl@pengutronix.de>
 <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
X-Virus-Status: clean
X-Anti-Virus-Server: fsav415.rs.sakura.ne.jp

This is a multi-part message in MIME format.
--------------9av9CEdamI3OzCLPoQ2BROxe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/29 17:56, Marc Kleine-Budde wrote:
> On 28.09.2026 20:45:13, Marc Kleine-Budde wrote:
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>
>> syzbot is reporting "struct j1939_ecu" refcount leak, which occurs when
>> netdev_hold() is called during ECU creation but the corresponding
>> netdev_put() is never executed because the parent "struct j1939_ecu"
>> object is leaked.
>>
>>   unregister_netdevice: waiting for vxcan1 to become free. Usage count = 3
>>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>>        netdev_hold include/linux/netdevice.h:4525 [inline]
>>        j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
>>        j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
>>        j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
>>        __sys_bind_socket net/socket.c:1920 [inline]
>>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>>        __do_sys_bind net/socket.c:1956 [inline]
>>        __se_sys_bind net/socket.c:1954 [inline]
>>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>>        netdev_hold include/linux/netdevice.h:4525 [inline]
>>        j1939_priv_create net/can/j1939/main.c:140 [inline]
>>        j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
>>        j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
>>        __sys_bind_socket net/socket.c:1920 [inline]
>>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>>        __do_sys_bind net/socket.c:1956 [inline]
>>        __se_sys_bind net/socket.c:1954 [inline]
>>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> The root cause lies in the error handling of j1939_sk_bind() during a
>> re-bind operation (binding an already bound socket to the same interface).
>> Currently, the function prematurely drops the old ECU references by calling
>> j1939_local_ecu_put() before verifying whether the new configuration can be
>> successfully acquired via j1939_local_ecu_get().
>>
>> If j1939_local_ecu_get() subsequently fails, the function unconditionally
>> calls j1939_netdev_stop() and clears jsk->priv. This leaves the socket in a
>> half-broken state where the old ECU's refcount has already been decremented
>> incompletely, but the socket destruct pathway (j1939_sk_sock_destruct) can
>> no longer perform proper cleanup because jsk->priv is NULL. As a result,
>> the old "struct j1939_ecu" remains orphaned on the priv->ecus list,
>> permanently leaking both the ECU object and the net_device reference held
>> inside it.
>>
>> Fix this by deferring the removal and release of the old ECU references
>> until after j1939_local_ecu_get() has successfully acquired the new
>> resources. As a side effect of this change, the socket's state no longer
>> changes when the re-bind operation failed.
>>
>> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
>> Assisted-by: Gemini-Pro
>> Fixes: f214744c8a27 ("can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed")
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Link: https://patch.msgid.link/deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> I've dropped the patch for now, the netdev bots gave the following
> review:
> 

syzbot found a reproducer, and I confirmed that this patch cannot fix this issue. 
Please drop this patch.

--------------9av9CEdamI3OzCLPoQ2BROxe
Content-Type: text/plain; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHNjaGVk
Lmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8
c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMv
c29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+
CiNpbmNsdWRlIDx1bmlzdGQuaD4KCnN0YXRpYyB2b2lkIGV4ZWN1dGVfb25lKHZvaWQpCnsK
CWludCBpZHggPSAwOwoJY29uc3QgaW50IE9ORSA9IDE7CgkvLyAgc29ja2V0JGNhbl9qMTkz
OSBhcmd1bWVudHM6IFsKCS8vICAgIGRvbWFpbjogY29uc3QgPSAweDFkICg4IGJ5dGVzKQoJ
Ly8gICAgdHlwZTogY29uc3QgPSAweDIgKDggYnl0ZXMpCgkvLyAgICBwcm90bzogY29uc3Qg
PSAweDcgKDQgYnl0ZXMpCgkvLyAgXQoJLy8gIHJldHVybnMgc29ja19jYW5fajE5MzkKCWNv
bnN0IGludCBmZCA9IHNvY2tldCgweDFkLCAyLCA3KTsKCS8vICBpb2N0bCRpZnJlcV9TSU9D
R0lGSU5ERVhfdmNhbiBhcmd1bWVudHM6IFsKCS8vICAgIGZkOiBzb2NrIChyZXNvdXJjZSkK
CS8vICAgIGNtZDogY29uc3QgPSAweDg5MzMgKDQgYnl0ZXMpCgkvLyAgICBhcmc6IHB0cltv
dXQsIGlmcmVxX2Rldl90W3ZjYW5fZGV2aWNlX25hbWVzLCBpZmluZGV4X3ZjYW5dXSB7Cgkv
LyAgICAgIGlmcmVxX2Rldl90W3ZjYW5fZGV2aWNlX25hbWVzLCBpZmluZGV4X3ZjYW5dIHsK
CS8vICAgICAgICBpZnJfaWZybjogYnVmZmVyOiB7NzYgNjMgNjEgNmUgMzAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDB9CgkvLyAgICAgICAgKGxlbmd0aCAweDEwKSBlbGVt
OiBpZmluZGV4X3ZjYW4gKHJlc291cmNlKSBwYWQgPSAweDAgKDIwIGJ5dGVzKQoJLy8gICAg
ICB9CgkvLyAgICB9CgkvLyAgXQoJbWVtY3B5KCh2b2lkKikweDIwMDAwMDAwMDBjMCwKCSAg
ICAgICAidmNhbjBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAw
MCIsIDE2KTsKCWlmIChpb2N0bChmZCwgMHg4OTMzLCAweDIwMDAwMDAwMDBjMCkgIT0gLTEp
CgkJaWR4ID0gKih1aW50MzJfdCopMHgyMDAwMDAwMDAwZDA7CgkvLyAgc2V0c29ja29wdCRz
b2NrX2ludCBhcmd1bWVudHM6IFsKCS8vICAgIGZkOiBzb2NrIChyZXNvdXJjZSkKCS8vICAg
IGxldmVsOiBjb25zdCA9IDB4MSAoNCBieXRlcykKCS8vICAgIG9wdG5hbWU6IHNvY2tvcHRf
b3B0X3NvY2tfaW50ID0gMHg2ICg0IGJ5dGVzKQoJLy8gICAgb3B0dmFsOiBwdHJbaW4sIGlu
dDMyXSB7CgkvLyAgICAgIGludDMyID0gMHgxICg0IGJ5dGVzKQoJLy8gICAgfQoJLy8gICAg
b3B0bGVuOiBsZW4gPSAweDQgKDggYnl0ZXMpCgkvLyAgXQoJc2V0c29ja29wdChmZCwgMSwg
NiwgJk9ORSwgc2l6ZW9mKE9ORSkpOwoJLy8gIGJpbmQkY2FuX2oxOTM5IGFyZ3VtZW50czog
WwoJLy8gICAgZmQ6IHNvY2tfY2FuX2oxOTM5IChyZXNvdXJjZSkKCS8vICAgIGFkZHI6IHB0
cltpbiwgc29ja2FkZHJfY2FuX2oxOTM5XSB7CgkvLyAgICAgIHNvY2thZGRyX2Nhbl9qMTkz
OSB7CgkvLyAgICAgICAgY2FuX2ZhbWlseTogY29uc3QgPSAweDFkICgyIGJ5dGVzKQoJLy8g
ICAgICAgIHBhZCA9IDB4MCAoMiBieXRlcykKCS8vICAgICAgICBjYW5faWZpbmRleDogaWZp
bmRleF92Y2FuIChyZXNvdXJjZSkKCS8vICAgICAgICBuYW1lOiBpbnQ2NCA9IDB4MTAyMDMw
NDA1MDYwNzA4ICg4IGJ5dGVzKQoJLy8gICAgICAgIHBnbjogY2FuX2oxOTM5X3BnbiB7Cgkv
LyAgICAgICAgICBwZ25fcHM6IGNhbl9qMTkzOV9wZ25fcHMgPSAweDAgKDEgYnl0ZXMpCgkv
LyAgICAgICAgICBwZ25fcGY6IGNhbl9qMTkzOV9wZ25fcGYgPSAweDAgKDEgYnl0ZXMpCgkv
LyAgICAgICAgICBwZ25fZmxhZ3M6IGNhbl9qMTkzOV9wZ25fZmxhZ3MgPSAweDAgKDEgYnl0
ZXMpCgkvLyAgICAgICAgICBwZ25fdW51c2VkOiBjb25zdCA9IDB4MCAoMSBieXRlcykKCS8v
ICAgICAgICB9CgkvLyAgICAgICAgYWRkcjogY2FuX2oxOTM5X2FkZHJzID0gMHgyMCAoMSBi
eXRlcykKCS8vICAgICAgICBwYWQgPSAweDAgKDMgYnl0ZXMpCgkvLyAgICAgIH0KCS8vICAg
IH0KCS8vICAgIGxlbjogYnl0ZXNpemUgPSAweDE4ICg4IGJ5dGVzKQoJLy8gIF0KCSoodWlu
dDE2X3QqKTB4MjAwMDAwMDAwMTQwID0gMHgxZDsKCSoodWludDMyX3QqKTB4MjAwMDAwMDAw
MTQ0ID0gaWR4OwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAxNDggPSAweDEwMjAzMDQwNTA2
MDcwODsKCSoodWludDhfdCopMHgyMDAwMDAwMDAxNTAgPSAwOwoJKih1aW50OF90KikweDIw
MDAwMDAwMDE1MSA9IDA7CgkqKHVpbnQ4X3QqKTB4MjAwMDAwMDAwMTUyID0gMDsKCSoodWlu
dDhfdCopMHgyMDAwMDAwMDAxNTMgPSAwOwoJKih1aW50OF90KikweDIwMDAwMDAwMDE1NCA9
IDB4MjA7CgliaW5kKGZkLCAoc3RydWN0IHNvY2thZGRyICopIDB4MjAwMDAwMDAwMTQwdWws
IDB4MTgpOwoJLy8gIGNvbm5lY3QkY2FuX2oxOTM5IGFyZ3VtZW50czogWwoJLy8gICAgZmQ6
IHNvY2tfY2FuX2oxOTM5IChyZXNvdXJjZSkKCS8vICAgIGFkZHI6IHB0cltpbiwgc29ja2Fk
ZHJfY2FuX2oxOTM5XSB7CgkvLyAgICAgIHNvY2thZGRyX2Nhbl9qMTkzOSB7CgkvLyAgICAg
ICAgY2FuX2ZhbWlseTogY29uc3QgPSAweDFkICgyIGJ5dGVzKQoJLy8gICAgICAgIHBhZCA9
IDB4MCAoMiBieXRlcykKCS8vICAgICAgICBjYW5faWZpbmRleDogaWZpbmRleF92Y2FuIChy
ZXNvdXJjZSkKCS8vICAgICAgICBuYW1lOiBpbnQ2NCA9IDB4MCAoOCBieXRlcykKCS8vICAg
ICAgICBwZ246IGNhbl9qMTkzOV9wZ24gewoJLy8gICAgICAgICAgcGduX3BzOiBjYW5fajE5
MzlfcGduX3BzID0gMHgwICgxIGJ5dGVzKQoJLy8gICAgICAgICAgcGduX3BmOiBjYW5fajE5
MzlfcGduX3BmID0gMHhlZSAoMSBieXRlcykKCS8vICAgICAgICAgIHBnbl9mbGFnczogY2Fu
X2oxOTM5X3Bnbl9mbGFncyA9IDB4MCAoMSBieXRlcykKCS8vICAgICAgICAgIHBnbl91bnVz
ZWQ6IGNvbnN0ID0gMHgwICgxIGJ5dGVzKQoJLy8gICAgICAgIH0KCS8vICAgICAgICBhZGRy
OiBjYW5fajE5MzlfYWRkcnMgPSAweGZmICgxIGJ5dGVzKQoJLy8gICAgICAgIHBhZCA9IDB4
MCAoMyBieXRlcykKCS8vICAgICAgfQoJLy8gICAgfQoJLy8gICAgbGVuOiBieXRlc2l6ZSA9
IDB4MTggKDggYnl0ZXMpCgkvLyAgXQoJKih1aW50MTZfdCopMHgyMDAwMDAwMDAxODAgPSAw
eDFkOwoJKih1aW50MzJfdCopMHgyMDAwMDAwMDAxODQgPSBpZHg7CgkqKHVpbnQ2NF90Kikw
eDIwMDAwMDAwMDE4OCA9IDA7CgkqKHVpbnQ4X3QqKTB4MjAwMDAwMDAwMTkwID0gMDsKCSoo
dWludDhfdCopMHgyMDAwMDAwMDAxOTEgPSAweGVlOwoJKih1aW50OF90KikweDIwMDAwMDAw
MDE5MiA9IDA7CgkqKHVpbnQ4X3QqKTB4MjAwMDAwMDAwMTkzID0gMDsKCSoodWludDhfdCop
MHgyMDAwMDAwMDAxOTQgPSAtMTsKCWNvbm5lY3QoZmQsIChzdHJ1Y3Qgc29ja2FkZHIgKikg
MHgyMDAwMDAwMDAxODB1bCwgMHgxOCk7CgkvLyAgc2VuZG1zZyRjYW5fajE5MzkgYXJndW1l
bnRzOiBbCgkvLyAgICBmZDogc29ja19jYW5fajE5MzkgKHJlc291cmNlKQoJLy8gICAgbXNn
OiBwdHJbaW4sIG1zZ2hkcl9jYW5fajE5MzldIHsKCS8vICAgICAgbXNnaGRyX2Nhbl9qMTkz
OSB7CgkvLyAgICAgICAgYWRkcjogbmlsCgkvLyAgICAgICAgYWRkcmxlbjogbGVuID0gMHgw
ICg0IGJ5dGVzKQoJLy8gICAgICAgIHBhZCA9IDB4MCAoNCBieXRlcykKCS8vICAgICAgICB2
ZWM6IHB0cltpbiwgaW92ZWNbaW4sIGFycmF5W2ludDhdXV0gewoJLy8gICAgICAgICAgaW92
ZWNbaW4sIGFycmF5W2ludDhdXSB7CgkvLyAgICAgICAgICAgIGFkZHI6IHB0cltpbiwgYnVm
ZmVyXSB7CgkvLyAgICAgICAgICAgICAgYnVmZmVyOiB7MDggMDcgMDYgMDUgMDQgMDMgMDIg
MDF9IChsZW5ndGggMHg4KQoJLy8gICAgICAgICAgICB9CgkvLyAgICAgICAgICAgIGxlbjog
bGVuID0gMHg4ICg4IGJ5dGVzKQoJLy8gICAgICAgICAgfQoJLy8gICAgICAgIH0KCS8vICAg
ICAgICB2bGVuOiBjb25zdCA9IDB4MSAoOCBieXRlcykKCS8vICAgICAgICBjdHJsOiBjb25z
dCA9IDB4MCAoOCBieXRlcykKCS8vICAgICAgICBjdHJsbGVuOiBjb25zdCA9IDB4MCAoOCBi
eXRlcykKCS8vICAgICAgICBmOiBzZW5kX2ZsYWdzID0gMHgwICg0IGJ5dGVzKQoJLy8gICAg
ICAgIHBhZCA9IDB4MCAoNCBieXRlcykKCS8vICAgICAgfQoJLy8gICAgfQoJLy8gICAgZjog
c2VuZF9mbGFncyA9IDB4MCAoOCBieXRlcykKCS8vICBdCgkqKHVpbnQ2NF90KikweDIwMDAw
MDAwMDIwMCA9IDA7CgkqKHVpbnQzMl90KikweDIwMDAwMDAwMDIwOCA9IDA7CgkqKHVpbnQ2
NF90KikweDIwMDAwMDAwMDIxMCA9IDB4MjAwMDAwMDAwMjQwOwoJKih1aW50NjRfdCopMHgy
MDAwMDAwMDAyNDAgPSAweDIwMDAwMDAwMDI4MDsKCW1lbWNweSgodm9pZCopMHgyMDAwMDAw
MDAyODAsICJceDA4XHgwN1x4MDZceDA1XHgwNFx4MDNceDAyXHgwMSIsIDgpOwoJKih1aW50
NjRfdCopMHgyMDAwMDAwMDAyNDggPSA4OwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAyMTgg
PSAxOwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAyMjAgPSAwOwoJKih1aW50NjRfdCopMHgy
MDAwMDAwMDAyMjggPSAwOwoJKih1aW50MzJfdCopMHgyMDAwMDAwMDAyMzAgPSAwOwoJc2Vu
ZG1zZyhmZCwgKHN0cnVjdCBtc2doZHIgKikgMHgyMDAwMDAwMDAyMDB1bCwgMCk7Cn0KCmlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCW1tYXAoKHZvaWQgKikgMHgxZmZm
ZmZmZmYwMDB1bCwgMHgxMDAwLCAwLCAweDMyLCAtMSwgMCk7CgltbWFwKCh2b2lkICopIDB4
MjAwMDAwMDAwMDAwdWwsIDB4MTAwMDAwMCwgNywgMHgzMiwgLTEsIDApOwoJbW1hcCgodm9p
ZCAqKSAweDIwMDAwMTAwMDAwMHVsLCAweDEwMDAsIDAsIDB4MzIsIC0xLCAwKTsKCXVuc2hh
cmUoQ0xPTkVfTkVXTkVUKTsKCXN5c3RlbSgiaXAgbGluayBhZGQgZGV2IHZjYW4wIHR5cGUg
dmNhbjsgaXAgbGluayBzZXQgdXAgdmNhbjAiKTsKCWFsYXJtKDEwKTsKCXdoaWxlICgxKSB7
CgkJaW50IHBpZCA9IGZvcmsoKTsKCQlpZiAocGlkIDwgMCkKCQkJZXhpdCgxKTsKCQlpZiAo
cGlkID09IDApIHsKCQkJZXhlY3V0ZV9vbmUoKTsKCQkJZXhpdCgwKTsKCQl9Cgl9CglyZXR1
cm4gMDsKfQo=

--------------9av9CEdamI3OzCLPoQ2BROxe--
