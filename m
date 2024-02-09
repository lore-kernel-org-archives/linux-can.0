Received: from projects.drlauer-research.com (projects.drlauer-research.com [88.99.0.140])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA50B53398
	for <linux-can@vger.kernel.org>; Fri,  9 Feb 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.0.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500280; cv=none; b=F9pI746VLVAsVym/3efFs9POOJ2fI3muHHU2LldiPJzZF4mlSoSKFyIbg47ZUHWvFTSju4SLPRsCAV1J/iIZlP6Ohz3e06d1aj9qkY5E2knnQrfhiwF6LEn+nu2P9A5HQ0doeE+ig79tyzsKh7ZwESMT/uxgChd13tYjbjKENaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500280; c=relaxed/simple;
	bh=7X55t1H24dEBPb21FTKsWuMY24j8tfHnfx33qsQ8mK0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=VJDPTZF3DvBf41/MfGa+twVrks+/iOIafQQswNFLI3ac+TR9dwa2WVNjaJfgV8HYwB7Uripay50OhqkueKeWkVP9VGVB0Ii+DulxIPV5B83pOfX5hVrURtfzJ3JcwRG6kqxQGgTh/0678kq2KaWfc2ZP/dwleJQIalz1rei9q0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de; spf=pass smtp.mailfrom=vanille.de; arc=none smtp.client-ip=88.99.0.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanille.de
Received: from smtpclient.apple (ip-109-090-164-198.um36.pools.vodafone-ip.de [109.90.164.198])
	by projects.drlauer-research.com (Postfix) with ESMTPSA id 2F35A48018A
	for <linux-can@vger.kernel.org>; Fri,  9 Feb 2024 18:29:10 +0100 (CET)
From: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Protocol recommendation for CAN(FD)-USB adapter
Message-Id: <0671FD01-F7C3-41C0-BD66-9E67150AB2C9@vanille.de>
Date: Fri, 9 Feb 2024 18:28:59 +0100
To: linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)

My team and I have designed and developed
a new CAN(FD) adapter based on ESP32S3 and MCP2518fd
primarily aimed at ECU firmware reprogramming,
but eventually also for the use as OBD2-adapter,
CAN-logger, etc.

The next incarnation will also have a=20
USB interface and I=E2=80=99m planning the necessary
changes for its firmware.

I would like it to be compatible with SocketCAN
out of the box =E2=80=94 optimally without writing a
Linux driver, but rather reusing an existing one.

Which of the mainline SocketCAN drivers would you recommend
basing my USB protocol on? =46rom a quick glance,
I=E2=80=99m leaning towards GS-USB, since this already
supports different hardware families.

Best regards,

Michael Lauer.=
