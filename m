Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581C34B437
	for <linux-can@vger.kernel.org>; Thu, 17 Sep 2026 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789623943; cv=pass; b=XJdj9/AHmovNcEvMghqolvC/X6g5HuwRQ5SylMUGFliN3QXt0e2Z5cokVUSObAJeI0WsePAHJRh2g+3Z7gs8gXkw5VPLNLQjF0KEqzDtkCV5+N/sBTC0Ir4vYgYNVjxU+ehAb10mKONgmMEeer3Kl96/bJfZsV9OgGrf4GGZK08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789623943; c=relaxed/simple;
	bh=TLb2nOqtBItk4KOsON4925LGI4M9C0ksEUGbwyjyQuc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=flDV3/NReefQ9lJUZJfVG0lYta5xrPVT/yIGf8W4RPoZB8YZHmIN2MZv/OCz28QMabVCh8eF/G17Wjdo9iKOy2xUdDJ5Xc5MZn/zllP8aEOJdSyVxHipyL39atdfYk00BhF96MU4NgpQ51V17mwtSzkFaMlBeItuXv6tQOb37Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlZ62d0n; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlZ62d0n"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso55574866b.2
        for <linux-can@vger.kernel.org>; Wed, 16 Sep 2026 22:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789623940; cv=none;
        d=google.com; s=arc-20260327;
        b=aRwf5VvlNSOoeVTFCYIzeRcuYnQahjAP9cC5xQalXFvPjBuYQnAWHENtZeCdpkcAhr
         1OL45qXkwDczirtNxFGE+qHtdptOAbpvv83s51TR6XgfiBeDsqYPgCx4WwhmjIPDnkxK
         6gmStxZE8KUCFjUqk7a3dFD0XZr4Xh+xd6OW0zgPRE1r1cjuK6GN9qd7UnE/MgIRzu3a
         0kTYu/xhxDocZxlRIMbym67bpFpbsGzhPJ8P9+LvDwpMG/cXIUdfHTfGaOww6iBhbIFY
         0nfxd5wtMl0m70UWAXCy6YHouBTFWTtSjK0A2Ku/CBQEkgaVR6SWL/PLR6cTa+RAf7Jz
         K+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WxkFkzssA6pC9icCvytDKFmiFi1j9AIom1UsTbZeHsc=;
        fh=P9epx+pv5dIxDyg7L6PKT2SJLnckDxEwFyyxm6tGHLA=;
        b=bw99ad173lzoNuwzltECwwgA9fqlHCVT+zVGkRZ/w4esRuae9pndOc8AxnJTPZXhaS
         n4yT0qFO2lMIE2hjrnMd7UafpjwjmZKht9v1OBTyVO1O2wcrjPGx8QhaS0mzZKdR+2zV
         OC+BBd1OCs49OhrTB1OhVDZS8pE5PGwOjWhL3A7Zazc3T7TITVcdmzAGtB/qTmPQN2A8
         WB9XsXLWvvYggyvngxuLm60Hiw2mpTYaiaCJTrbKXjGt+vJc683Qx73NoyuKWzz+4H7D
         QILy7ov6j9uW1I6XmRXAOmm3l+T/h/65mvyB9VoLszondVN29eJb45csTTt5fJ7EeGwg
         Lwuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623940; x=1790228740; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WxkFkzssA6pC9icCvytDKFmiFi1j9AIom1UsTbZeHsc=;
        b=DlZ62d0n/G0h0JL2beJLQGJOjzn44+dOVq6qbcfDVOqHktMLIb63dvFgjhKgGBevDq
         fK0f/ecIaijY0pn3ERGwd8tSYJ9BkiXiLIWxgI0XrSVdBmgQUaSvCmzea8fX2FM9BUzf
         JzPmivMX6FXLlX3bglO9RHq6aPGDH9qaPcsmC4d3hK4PwX13NH5KZUutjfADrgrrJIXZ
         aVwEoaUu0Us9hSkmnem31Yw+FXzAUCQbGOkYps4erhMuqvFnbUmyRTGIqRhdlMQyLgnf
         fOKV6zo80t+b30t9jyiNZ6K/zOfscTLpzpunugVAj1jjxwjH9LXXclXvRLaac1jrPn8T
         dKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623940; x=1790228740;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WxkFkzssA6pC9icCvytDKFmiFi1j9AIom1UsTbZeHsc=;
        b=l53TpakQGfU2eIK25dUrVYrdnCjU5GSaNyzTEQ9iM0Te5dt/lgQ9/9WFt5VEPurG3E
         b8FV/dPw/Zhb2v/H8Q6uJZO0c4inHDJu3dq7S8FxTXFZE3fSvi0QghHWqPl6Iv405zQm
         9SbT/uZH9X01iNhWT6K7oHLig7fP/s369A84Az1Yw+1kpXjP7L8ovKCqxahZzp7ffnfs
         rxT6CxwPj2HKzrKMcC714Zm7B2VYwrZEXgxO76Pwmi038vzBPpCXPkQszD7u+WxiY5UB
         VJnLzrYVmuob4DINM/aTVA+3W9XmyOyEXRc+pPg9iIa4nFj2vn6wbTgMfVukkGQicZE7
         eqHA==
X-Forwarded-Encrypted: i=1; AKwUvBy0ee2A+FISnlinv/QIF5Cu28tQoGp4cVkpDBFtd5yKIL5UHy07IAYrRzqm8VybGhuisTM64ne7cI4=@vger.kernel.org
X-Gm-Message-State: AFuF++kA+QBftU4bSmVmBsJshhx/NDTGHq4+mu5gAQFVaHp7/ucgjSmO
	us7wZTqiySYQ3lBAS/IJNxKUdwGDrJBNzPK+ukfyZPUig2ZUTKV1BUxi30kZez6S9xPoUQdE7yB
	0PU/FJEyPmAxD1nTAMOdET9rmqpWz1kU=
X-Gm-Gg: AYBFou1oyg9KaX+mOpMdVztPq9X9FB8vemGaXjrOYlg+wu+UdLRYuaFsh+7iod6pQY/
	jR/7nM+akXsK6k5ByeC1dMSMgxOCC+/P7R8oy6SncT33EYm0NiwAYrvt7ClVBA0vy5wMdpzXRsq
	HuUnvObToUC2vgOLcPcErfB2JbidItzHh4tcKHMslz2Zb1Eaj0u/V84W5f0ZoODKYHeDJBrJ4wQ
	24p6hzAyCgNIu9T+o75GM4qVX9Q7hwsHEHZ7qBq9ye/7WJ5cKkN0GsX13P9uJ3qBp+NVNoieVLP
	rnFTIHUMDVDmHxh5tDtUQcN5gi6od+OUCG8257gdAR1e++q9nmJHx4Ou
X-Received: by 2002:a17:907:d14:b0:c29:4634:5c99 with SMTP id
 a640c23a62f3a-c29e52918a9mr365267766b.4.1789623939705; Wed, 16 Sep 2026
 22:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuchao Zhang <ndaugoing@gmail.com>
Date: Thu, 17 Sep 2026 13:45:28 +0800
X-Gm-Features: AcwNN1W1ZtD3gP38DTGoOvPF8n7x5MxoqmLZYUzaSGzaLyTncN9yjIast4J_p-4
Message-ID: <CAC2BP3LyU5Qc80YTk7nq4vS96QKiufyAAdkNjVMr_DvcO=9K8w@mail.gmail.com>
Subject: [patch 0/1]can: restore skb header initialisations in init_can_skb()
To: mailhol@kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, linux-kernel@vger.kernel.org, socketcan@hartkopp.net
Content-Type: text/plain; charset="UTF-8"

Hi,

This series fixes a regression of the classic skb_under_panic in
packet_rcv_spkt() that was originally fixed in 2015 and re-introduced by
9f10374bb024 ("can: remove private CAN skb headroom infrastructure").

#regzbot introduced: 9f10374bb024

When an RX CAN skb (mac_header still at the 0xFFFF sentinel) reaches a
SOCK_PACKET socket, the length calculation in skb_push() overflows and
triggers skb_under_panic -> kernel BUG -> full machine panic. Because the
BUG occurs in softirq context, the machine panics even when
panic_on_oops=0.

Call chain (confirmed on 7.3.0-rc2, arm64 qemu):

  slcan_bump_frame
    -> alloc_can_skb          (init_can_skb no longer resets mac_header)
    -> netif_rx
    -> process_backlog
    -> __netif_receive_skb_core
    -> deliver_skb
    -> packet_rcv_spkt        <- sink (af_packet.c:1914)

Historical context:

  - 2014-07: Originally reported by Austin Schuh on linux-can
  - 2015-02: Fixed by 969439016d2c (producer-side resets)
  - 2020:    packet_rcv / tpacket_rcv got dev_has_header() checks;
             packet_rcv_spkt was left unprotected
  - 2026-02: 9f10374bb024 deleted the resets -> regression re-introduced

Patch 1 restores the three skb_reset_*_header() calls in init_can_skb(),
matching the 2015 fix.

I also prepared a defensive check in packet_rcv_spkt() itself
(skb_mac_header_was_set()), which would protect against any future
producer that forgets to set the mac header. I can send it separately
if the maintainers would like it.

Reproducer (100% reliable):

  modprobe can can-dev slcan
  # attach N_SLCAN to a pty pair, bring can0 up
  # create SOCK_PACKET socket bound to can0
  echo -ne "t1238DEADBEEFDEADBEEF\r" > /dev/pts/X

Result:
  skbuff: skb_under_panic: len:-65455 put:-65471 ...
  kernel BUG at net/core/skbuff.c:214!
  Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt

Thanks.
