Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660409;
	b=nzpcbgq3u7IfEM75UAyBgEtMjlYqo2mHBE5oxzqDPwl2yL4FFZ6jbTfrzw92XNhTCimn
	 enthMl4YgXsnCqFwwo7e1InJoWIlZj5nyurBVIhW8N15h+oVKvDY/Dz7LAWnR3kiqZVFe
	 NhKtqCkqpCf00NqjMGwKyDQB554lh35+WVk47tW/IDpgUn7jkFljebL8LVYYDClo5kuGk
	 bcwFw19rGCGZtFnQLkLtPukdImdwdBfR/3N66D4vmor8XnQJ10Qy27z60DpUiGNtx1aWu
	 6Z4RK/wiyUTWCTF/jj2c+8lTGUkI9rSI2VoZDXhAeHRQ9lKSI/iUqMcaoqCb1hEme9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660409;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Bx9dmLmwaYxQpG+BTwnnaQsOLchBU9zfmloHGphj4zQ=;
	b=jGr5Et92rbA3yTDG8TdgcpVYDW1A2RTrWAQ4XXKrWrg+za04HUQvJ9oS/INXkCiip8NG
	 4bH0ikRh25vumds0g0KBDL7rLUn7/VbYeuBZ/PP4JiaSiAPkz5du000gZjpe38FMl9DTK
	 easgcKDIXPaeWiZiivIYBHC2QUBCoOWOddlcTvSRJvMtAPq25wbTgGu7xlZ949P7lo+iX
	 CdlWdMC4dICzvx1WnvlebQFzp7Lcp57nw6/c8FWuCQkMvI6QrdCXz1B2/qSl6wnK1Gh9D
	 iYQoU4URfeiVxx0OX311g5DjpHQnQbVKLE3usv7ACBQFCIHza2g9uW6KLs7YqAgEGgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=hZ8h00ey;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B076606A324;
	Mon,  2 Nov 2026 23:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B076606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=hZ8h00ey
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793660408; x=1825196408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bx9dmLmwaYxQpG+BTwnnaQsOLchBU9zfmloHGphj4zQ=;
  b=hZ8h00eyNEtfyiRpZiTLmHQQMFgm8LBG8LX1ra/QKs3Fwb+yIlL87oYO
   sRmMHcx+aeuklcGspZ2pUBrre2/b6TxQOjDfKKVmMsiWUBBKu5AudYEOq
   pPTI2a+pre7AFMeTV74vq2NbU3GR4+3pC2MATjMRckYsO7iymnRYZdVDD
   IAzrdjy8BJ5vVHp58ipcUTRmrkzPyZKPUnGjO/cb+jfAJrlNz9PoQAVc4
   BhCdRKoRRtDa38GpH0odimfXjL2Siniq3xgyUcLF2daW03zNIXicvuuC4
   sIIhgsubNL+c0EBOLYnyPAbTPGKfrxUEgcVsmNQCqM3vqNBkIcjc4E/1Z
   g==;
X-CSE-ConnectionGUID: WvY3G8QwQGG/gSZwz0tpwA==
X-CSE-MsgGUID: t3Jm7TmkSGmQgejYS0juxg==
X-IronPort-AV: E=Sophos;i="6.27,192,1787011200"; 
   d="scan'208";a="32840507"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 23:00:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:10796]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.155:2525] with esmtp (Farcaster)
 id dc83c2e5-c588-43f6-9b27-c4d9065b0b4e; Mon, 2 Nov 2026 23:00:07 +0000 (UTC)
X-Farcaster-Flow-ID: dc83c2e5-c588-43f6-9b27-c4d9065b0b4e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 23:00:07 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 2 Nov 2026
 23:00:07 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: <netdev-bot+sashiko@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>, Pavel Pisa
	<pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, Harini T
	<harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>
Subject: Re: [PATCH v2 3/3] can: ifi_canfd: enable NAPI before starting the controller
Date: Mon, 2 Nov 2026 22:59:45 +0000
Message-ID: <20261102225945.1257987-1-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179353749137.3127.3654469722382202292@kernel.org>
References: <179353749137.3127.3654469722382202292@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sun, 01 Nov 2026 12:51, netdev-bot+sashiko wrote:
> With NAPI enabled here, can ifi_canfd_poll() now run at the same time as
> the rest of ifi_canfd_start()?

I think the analysis is right, and moving the CAN state and the error
counter writes into ifi_canfd_reset_config() and masking the interrupts
there makes sense. With those changes, the patch reorders the reset,
error counter and interrupt mask writes on both the open and the bus-off
restart paths. At that point the change is no longer obviously correct
by inspection, and I do not have IFI CAN FD hardware to test it, so I
am not confident continuing with it.

I will drop this patch and send v3 with only the ctucanfd and xilinx_can
patches. The race in ifi_canfd_open() remains, and this thread may be a
useful starting point for someone who can test a fix.

pw-bot: cr
