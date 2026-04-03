Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949E23E32B
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209817; cv=none; b=ocmPbDWvlbvIBImRAh1fp6fJdIZm5PCXktTLh6MCdfAfOfIpXdbDVrYWiYn4OaA0n4t98wRFV63O2pz2NKO7qaeIOGZp/XoDLjMiY56oM2RXbcD9blOk/Bk+ob1Bc9SnSAIbIVCYm84qFrEkJl6KbckrrEmpoJtk1sJkfwg94H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209817; c=relaxed/simple;
	bh=G/XTTldBTOOM0QMK0+ZZGC/DPdHMFsB/H2fYQDGye4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpMczXN9N9+aSLwZYXYaxVZPYakFz7if+Upz+wyrMi6Ns6nVknjR+CNi8RWyuP6uLPjZaq/YjB3aAYp9JyLt2jKM6v2IuhwzHCatdcpuPlK/dUbJRaPxZ5NrpDCyw2R5nR1ci2DQAvpe8eq6ZJPwZnUIM4pxpD/lmECNZ5Ilks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm6gx65V; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm6gx65V"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fb14227cso23557915e9.3
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2026 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209807; x=1775814607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2ExhCCG/Ktc9lkeQiNOn03CChrBuSwykagKy2evogQ=;
        b=Zm6gx65VX/5Kx7BRz3DgbZPzZ1VlCFHrIScUrpQUjYouEnWqOyl3/sfq65rGuNpeM4
         SvBKoVhOR9vdDvGuQ1F2xIdQKk8lYqot5enZ+f8IEAs5u5DB7uPlUtonl5XsFOkhtEGz
         tln8Rq9iR1fdTU5mieM8Xrg3T0R+Hq8fA+Ym+VWu6wh3m2hpedhZjPPEbKF2I4611mos
         1AqIL8oPmDmvlKIUkitjMpqvHNm4s0W0+AUR9Q/MR852OPUQ99INU2gznEHoU4X90Omy
         a3U/+p4fbGzDbo/Ttw4psIr6hmGweY7UI1XzNXrqK9qYAa1xkPF5BUkGwdcS2vgW0nBr
         1SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209807; x=1775814607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2ExhCCG/Ktc9lkeQiNOn03CChrBuSwykagKy2evogQ=;
        b=rFW0peE73TYno2ENourUiOIA+JIEDMbeCK4W5J97XWvfFAmZGSlgQIP4rt6fYJx8k1
         92hJp2EOqKGhniWcIvgnfaKnXsnBRmQyLmJ9+EDXVL4FynBcl1h8S2AyFG4YPPuMLUN/
         1GCnIA1n9y4xttsr0YtLPBXe6HHGtwlT81FGb+2HSaNxf4buq7E9Yvp5oFxfGnJWWs6Y
         6gJCxkM/Bksdi2VmtvipBEkxGzjltxnlCKCi2sywO9Y0A838SJhov437X68C3QQGXiYI
         0sT0Bkp7eIpGFwGfn0Z9Tk/RlXiM+pb446Lekb96CAxa+bFbKS0jt8uD+QxVnouDDxjo
         maog==
X-Forwarded-Encrypted: i=1; AJvYcCV5AsPpGi9sn+aMQ7FtsNfsKITmefzQZMmMqZLlIDeNDjktQd/K/ZqsE8Fs4TQK6Pg35KFLJkjnxOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBc0wIPou67EIdTdxSXspzup21iBkNJAuw21X+/742NqQYfbcK
	/vBlHom7mxL7dHqIsjBIIceI+tM2MPkNUMfiJIZberP9l8gzlFw1NxMl
X-Gm-Gg: ATEYQzyQys+ySqVQSvB1EbR1FpccmOzr31pnecz9LOrQjkXAD1RiyFpwNpA/9tn0yRw
	vz+oHukrYmiG4fxc+mHNuAe3qOfZFoi9u6PvafLsh5khatsvOBwcKMFD1yngDUHzlKJLCWsetWz
	Kx5Zy+d7JJXswtA2dimzVLvIr6zG7ZdPDj2T6EdMoOJJ01BsJx3qK11tXDL1un0ErlMpIwb12JL
	0WRIvxU4SxYcp/xWiW1BkLx0cbIXXvuldA1GcYlFxaGhR0mG5LQ7fB92ra1hlaC9rJgTEsMEhfj
	jy7tHiqrJb/rlVc7OEpH9Mrac4exVWHQ4bfJGiDB6F/ezbMbN16u03BiQFcQjidpbFsSh19tsa3
	2PTsA5U+kC0QyWrnHTDEiy06LqhrmcSd1KSJemDrwhleqijiWZ1PPkt0buGzLpNcFtLX8cizdKl
	vfK5zn8Mm+7mfPJAWXb+DrRN6lt1xclWfff7V8bgEogEsVcSmU
X-Received: by 2002:a05:600c:34c8:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-48899715377mr39107515e9.2.1775209807303;
        Fri, 03 Apr 2026 02:50:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:58b8:b4b6:c8e1:8690])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fc89c0sm25965355e9.1.2026.04.03.02.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:50:06 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode selection
Date: Fri,  3 Apr 2026 10:49:57 +0100
Message-ID: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The CAN-FD IP supports the below Bus-Off recovery modes:
1) ISO11898-1 compliant
2) Entry to Channel Halt mode automatically at bus-off entry
3) Entry to Channel Halt mode automatically at bus-off end
4) Entry to Channel Halt mode (in bus-off state) by program request

Add support for Bus-Off recovery mode selection via the
renesas,bus-off-recovery-mode device tree property. If the property is
absent, it defaults to RCANFD_CCTR_BOM_BENTRY (entry to Channel Halt mode
automatically at bus-off entry) for backward compatibility.

Testing:
CANBUS-OFF trigger on RZ/G3E SMARC EVK:-

Enable
CONFIG_EXPERT=y
CONFIG_GPIO_SYSFS=y

echo 556 > /sys/class/gpio/export
echo 557 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio556/direction
echo out > /sys/class/gpio/gpio557/direction
echo 1 > /sys/class/gpio/gpio556/value
echo 1 > /sys/class/gpio/gpio557/value

ip link set can0 down
ip link set can1 down
ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on restart-ms 100
ip link set can1 up type can bitrate 1000000 dbitrate 4000000 fd on restart-ms 100

Set the switches SW_GPIO8_CAN0_STB and SW_GPIO9_CAN1_STB to STANDBY mode

candump can0 &
cansend can1 123#1122334455667788

This will trigger BUS-OFF as CAN is in STANDBY mode

Then, Set the switches SW_GPIO8_CAN0_STB and  SW_GPIO9_CAN1_STB to
NORMAL mode, the messages started receiving after bus-off errors.

With BOM=0, after bus recovery, Bus-Off recovery interrupt is triggered
by CAN-FD IP.

Biju Das (3):
  dt-bindings: can: renesas,rcar-canfd: Document
    renesas,bus-off-recovery-mode property
  can: rcar_canfd: Add support for Bus-Off recovery mode selection
  can: rcar_canfd: Handle Bus-Off recovery interrupt

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 11 ++++++++++
 drivers/net/can/rcar/rcar_canfd.c             | 20 +++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.43.0

