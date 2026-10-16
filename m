Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977C342151
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131112; cv=none; b=nyatPrtzywa/KxwApH1pQ/ibnk/H1Hz/FKS6v5YQCs8I5fmenKLAeU4ulNqT6ECmZMtvRTeAWK7iGF6DRBXrlAZdzXEgh+hYE14GeLmNo1CaUjwa4UKQ1fRnH2Q/UJX8wNtvQfjqfCc6CIKGPJSqSgQeLEL+nxDy2D12T/WZkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131112; c=relaxed/simple;
	bh=EJf7XbhKkvHllbC0gV+NBrRWaZCEquM0yuYvJXfnYIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i44LtKj4hju373uNTt7vagg4ikjfWG5O85tuoseHCPi4PgoCAeGf8+HzIelW3mjGce0NSjyjGgRFG03TC+IJ75PJhtC/gUqPYkxRZub77DKCY6eYlYvnYmLZ31irKYSBIBvV/R1nRPsoor7SYU67cHuuMXc2p9wZ4eoOhToAktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNFGOOIc; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNFGOOIc"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4425769eec.0
        for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131110; x=1792735910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=61F7VlL8GG8+4/XGP5lm/szHzOUYPutMS6YONNAlbY0=;
        b=nNFGOOIcPHu9g23AvqaWFwA2bJYi4r+Rd0eOzUALzgxfwrdeO9SDSg1eosnlyIb1wJ
         SY3j/4eQtUSB1/ayXCS1k4Pkz3wk0pFCD4VOm9RSkokmx3vvFKTDrvKoXiQdmZsSxdBv
         2guBfZb9gP0SH7X/NRYh550j20IHMsryoQDgFDY8VuNtm/UNQXDXrjKJzbYP+IhKmNET
         i/9Ytua+Nn5EEtmnNa7FsvW508wUGs16DsLPV7H3DCRZqoTolHTBE5wUOCVPObH1Ptvt
         jEE2npARAoXY8vD+Yy+x/IOkmZfbC/E30Ggw+hlKZAHHzgQ1UgWIB7YbVcCUp2oWK7eJ
         Ls/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131110; x=1792735910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61F7VlL8GG8+4/XGP5lm/szHzOUYPutMS6YONNAlbY0=;
        b=AU22UKncMNwvb64oIv7HyAsQqCWUnpGPwERoI6thDZJw35+wO9cfFFbS/rRpbTEEmG
         7kjaKmAiF5qtZuezJeqiEKlz+n1EbLPzxIB2krUO6zWFdMk1EIVZETbFUr3Sc8KLsy/r
         MEF4Q/ULQMyPy5xOiN02xHfhx3Kzx+DB3c2pFRrna57pIGabp564OXn6KIwM6dtKbuow
         GimCR91Enn/9mg0Ze8qti/fickLGriglmvctfQiBMdBddB98FyV4mDGbo4xQIt98GDhW
         TWMT89ozsUyTb62ll3H/yd+BMk3XsADGU63aX9WrGifGfnmqw3BL67poVocZW6iUlsPW
         3GqQ==
X-Forwarded-Encrypted: i=1; AKwUvByBP5X6GDUa3QtbwfMv8QS3/Beut74gmFJQrgqlL5dj6bwQ3/D5LD1MdxFj0zWJSbqBNJ+synJZ0F4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY5q+PYbAwpkc65+AyHXyw8BoIYZipwxrsAXO4pQyeA4eqfM7p
	rBACmr5O95/uMz047jVSwIhksmQKbRECoRJonoPtdkMyKrPWk/7y/gZr
X-Gm-Gg: AYBFou3WHCfgThflKa5LPdEl6QPRdFebQ0QEbLgVgGtHSXc+SjmERsfogFZcCTkZQdI
	UcxvZv5BQjOTZXSioepoKuw+ebuAmabe++TVZfmiii30OK2kDnRZZSJf2BIdFXbAGo223QahlfW
	NrA64aB1n3gFXqEuBHbJP3ooU2TmQMd7O9QUBcSJd45OIK+W4GOxNifYIFoKr2cCRBiuwpKJy/g
	wiCebKE9ylH2GINwRyYNyYnJHCTKo/7/mLxg02IqnKcCzBnKHznE3QVK99Wu1xRq2vGLGqo5RMT
	dzg3m3qhnjYM3b8LA6AbdyahI+Nxfzel7cJdD39czuqmAYgiO2vaHTpD8uPwON3KUYmieUiIBpU
	YbA/Ls84iiy2NgJH0X9s/czPK5mXvQ5ZtaHjBNuJP60qCDFeQ/yNX/+av2l3XpIiszn+0DyxWuB
	NIUyfVEfZoW3blluf9Kj7CrhUSbNE9KwEaVdlsV5/gP+kkh37KYSDdSaCYj7b+pXPt6zARrX4YG
	rheDNYF/1wVqN98Yd2NXgkU656nud8FIh2yTFWN9JfNGXRhHTeixsKsng==
X-Received: by 2002:a05:7023:a56:10b0:143:46a6:b01f with SMTP id a92af1059eb24-16a6203dcf1mr27805573c88.31.1792131109882;
        Thu, 15 Oct 2026 23:11:49 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:49 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] can: don't discard the platform_get_irq() error in probe
Date: Fri, 16 Oct 2026 14:11:35 +0800
Message-ID: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four CAN platform drivers collapse every failure of platform_get_irq()
into a fixed error code:

    sun4i_can    -ENODEV
    at91_can     -ENODEV  (also tests irq <= 0, which cannot happen)
    janz-ican3   -ENODEV
    ifi_canfd    -EINVAL

sun4i_can, at91_can and ifi_canfd match through an of_match_table, so
of_irq_get() returns -EPROBE_DEFER while the interrupt controller has not
been probed. The probes overwrite it and the driver core stops retrying,
leaving the device unbound even though the interrupt controller appears
later.

janz-ican3 is different. The device is an MFD child of janz-cmodio, which
takes the interrupt from the carrier board's PCI device, and the driver
has neither an of_match_table nor an ACPI match, so it cannot see
-EPROBE_DEFER. Its commit message says so: that one is about the probe
not inventing an error code for a lookup that failed for another reason.

The patches return the lookup error unchanged, which is what the
neighbouring CAN platform drivers do, e.g. commit 057bd6168d98 ("can:
cc770: don't discard the IRQ lookup error in probe") and, from 2023,
commit 53b8d2be4d71 ("can: flexcan: fix the return value handle for
platform_get_irq()"). The 2023 sweep covered flexcan and c_can and missed
these four.

at91_can additionally has to split its combined lookup, because the
memory resource and the interrupt are currently checked in one condition
that returns -ENODEV for both. The memory resource keeps -ENODEV.

The only visible change is the error code for a device tree without an
interrupt: -ENXIO instead of -ENODEV or -EINVAL. The driver core treats
both as a failed probe.

All four apply with git am to mkl/linux-can-next testing and build
without new warnings on x86_64 with CAN_SUN4I, CAN_AT91, CAN_JANZ_ICAN3
and CAN_IFI_CANFD enabled; checkpatch.pl --strict is clean. None of the
four controllers is available here, so this is build tested only.

Assisted-by: LLM

Chaosheng Qu (4):
  can: sun4i_can: don't discard the IRQ lookup error in probe
  can: at91_can: don't discard the IRQ lookup error in probe
  can: janz-ican3: don't discard the IRQ lookup error in probe
  can: ifi_canfd: don't discard the IRQ lookup error in probe

 drivers/net/can/at91_can.c            | 9 +++++++--
 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 drivers/net/can/janz-ican3.c          | 2 +-
 drivers/net/can/sun4i_can.c           | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.43.0
