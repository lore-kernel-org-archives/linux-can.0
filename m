Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940791DDA18
	for <linux-can@vger.kernel.org>; Sun,  4 Oct 2026 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114470; cv=none; b=m7M7naE4ChSZ8VdSmBV+O2STxmlYZYphQdkjU2E5RPeLMrNpXlljVPRmXyeI4vFiGyYtcYvZA0W/YOaitACHNfa4v2UgAlYbPPPDffGJbLiCdc5+DvAJqoRacqwAMLEnEWojYG/g4ByDAcLlXT0Gq8IdCzo1EdOjEFQ9tK4WC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114470; c=relaxed/simple;
	bh=IkcVNVDOWAVMjOn+Co7h79jrCCz6DrAQFgrH+PkoTJU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=uKuhWX8OXC1cLwHdfSAwlUefN1ihxUMyysij8tVI1gz7eMHKwqzIOYuIrKTzRis/yhJoIX41vylKWWAYKGXcngADVxgjMSaKe1Wr7a3WN0Xjlfdc9GcrP7A55aZyMEAjFAUEIEeNpzyjF3Y7cgf1Gq5h12db2IIFLYDK1hGm25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 694BlPQJ076881;
	Sun, 4 Oct 2026 20:47:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 694BlP7O076878
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 4 Oct 2026 20:47:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Content-Type: multipart/mixed; boundary="------------dR9te2b6TlOchidKufYNoSa4"
Message-ID: <4ebfa1e1-0f8b-4848-8b12-6311f63eaf0f@I-love.SAKURA.ne.jp>
Date: Sun, 4 Oct 2026 20:47:25 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: j1939: cancel pending address claim timers from
 j1939_ecu_unmap_all()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp>
X-Virus-Status: clean
X-Anti-Virus-Server: fsav414.rs.sakura.ne.jp

This is a multi-part message in MIME format.
--------------dR9te2b6TlOchidKufYNoSa4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/29 20:47, Tetsuo Handa wrote:
> syzbot is reporting "struct j1939_ecu" refcount leak, for
> 
>   j1939_ecu_get(ecu);
>   priv->ents[ecu->addr] = ecu;
> 
> in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
> even after
> 
>   priv->ents[ecu->addr] = NULL;
>   j1939_ecu_put(ecu);
> 
> in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
> __j1939_rx_release() from j1939_netdev_stop() has completed.
> 
>   unregister_netdevice: waiting for vxcan1 to become free. Usage count = 3
>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>        netdev_hold include/linux/netdevice.h:4525 [inline]
>        j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
>        j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
>        j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
>        __sys_bind_socket net/socket.c:1920 [inline]
>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>        __do_sys_bind net/socket.c:1956 [inline]
>        __se_sys_bind net/socket.c:1954 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>        netdev_hold include/linux/netdevice.h:4525 [inline]
>        j1939_priv_create net/can/j1939/main.c:140 [inline]
>        j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
>        j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
>        __sys_bind_socket net/socket.c:1920 [inline]
>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>        __do_sys_bind net/socket.c:1956 [inline]
>        __se_sys_bind net/socket.c:1954 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fix this race condition by canceling address claim timers from
> j1939_ecu_unmap_all().
> 
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.553632-1-mkl%40pengutronix.de # [PATCH net 06/22]
> Assisted-by: Gemini-Pro gpt-6-astra opus-5-5
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
syzbot found a reproducer, and I confirmed that this patch fixes this issue. 
Please apply this patch.

--------------dR9te2b6TlOchidKufYNoSa4
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

--------------dR9te2b6TlOchidKufYNoSa4--
