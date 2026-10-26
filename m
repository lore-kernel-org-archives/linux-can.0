Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048367;
	b=kxNfrVlB14fyddw4V8cTQG+A7C4NFv2WD5lHrTP7I956LYygfaT3NthIaJL5oiqo2NZG
	 qYL+vcja8hwFmQvRBDo54DI9GDTiGvYH+dixU9fefzPbR3lmUSEbA//rqt6ZK6OjBIFC5
	 mZ/PFu62v51HQ79r9hgvA3dGniBer/Y0ygGFnz9oou4p96UWP/Rq3ja49LiRXhuT9m5yN
	 EpASjIt37iViCoc+wzvtFZatdG6n6vKhC3AI9NGUnFqAdSFOuj5nwV4DywU5XpugmSmB0
	 LphMsmbruUnMCgkbKjFtK8U7t7d6Dy5Z+TNaca0ZE9Vd99MZaxosUX91pqTZRp/66xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048367;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Qrq3FNW/0SEN44vJvKEC14nzqvJcKELdScbHaQ9C9/o=;
	b=EQIqGU+ZKT+ui4+euGP0se8TNkk32uIF20s4T1pjoeYTNTofj/zy00QZ7kTLYiWA+uCf
	 bGFhBw+OVOICk0tpP860a+3p8+95A6VMnLT6OlBfPT2NuuOZs0YmQbEHAStc/KCJ8njSr
	 wLfsEj5epmKXst2FwdtQRLWXK7mTeJqnX3J9rSsG2ptlFHT+nUzG/ocoL+upDrwPMaPsS
	 oUOzGeV09sXzlcBeauQmY5TKG6w4izpMSmFBH8+vn+CjI7xvVnz1/9nVFfjguMEv0vT7W
	 0pYwJS1hGZzWQ9ezj717bt0Kyf2gh8e7WpEtCLMVZmOpjKKuhZK/0AgO9JTwYB1h6Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=bS18TvyI;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3D606A31A;
	Mon, 26 Oct 2026 20:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D3D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=bS18TvyI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793048366; x=1824584366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qrq3FNW/0SEN44vJvKEC14nzqvJcKELdScbHaQ9C9/o=;
  b=bS18TvyId33lhEPNrAGSuwlBRRdN/670GTWdFlEflov90N5DhXYvSD2D
   XYfD4Ns8aUit4A16RU9wOUD9wzoy3xDSzjaef0yQigUuTxHxvYWIwGdd9
   BpaWsXcgiOySFmzVIqoWywDuVT/zWZ1GXb2828s4wYIQk4IS1ClSdVPzG
   etd7EK6mfXyYmRo8gBOmBn9A4M8Hy2cZwlcYV4qKP2ch3HRCkLyX+X4Fx
   xsIbTfQlW76zus7jrubernlsazIWZppYpEmvWfCztQl6rAd5zQH8M6sOH
   akGKWcNlPhtX+k4QdNmJwvRBIiFkvVstpnosmYbfImhd9lAr5LKkYOKPE
   g==;
X-CSE-ConnectionGUID: T/lN1pTdSIKq7SWI0pE8qw==
X-CSE-MsgGUID: uyvTqbsmT1mmcWIkKx8aPA==
X-IronPort-AV: E=Sophos;i="6.27,180,1787011200"; 
   d="scan'208";a="32211838"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:59:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:31130]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.86:2525] with esmtp (Farcaster)
 id 2862e1d7-248b-4929-83d9-7d6defe956f7; Mon, 26 Oct 2026 20:59:26 +0000 (UTC)
X-Farcaster-Flow-ID: 2862e1d7-248b-4929-83d9-7d6defe956f7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 26 Oct 2026 20:59:25 +0000
Received: from dev-dsk-patrzhan-2a-52a3f46b.us-west-2.amazon.com
 (172.22.91.11) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 26 Oct 2026
 20:59:25 +0000
From: Patrick Zhang <patrzhan@amazon.com>
To: <netdev-bot+sashiko@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, <linux-can@vger.kernel.org>, Pavel Pisa
	<pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, Harini T
	<harini.t@amd.com>, Michal Simek <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>
Subject: Re: [PATCH 3/3] can: ifi_canfd: enable NAPI before starting the controller
Date: Mon, 26 Oct 2026 20:58:55 +0000
Message-ID: <20261026205855.871681-1-patrzhan@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179274950592.3130.11275892525697074934@kernel.org>
References: <179274950592.3130.11275892525697074934@kernel.org>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, 23 Oct 2026 09:58, netdev-bot+sashiko wrote:
> With NAPI enabled before ifi_canfd_start(), can ifi_canfd_poll() now run
> against an IP that has not been reset yet? Can it also run alongside the
> reset and programming sequence in ifi_canfd_start()?

I think this is a valid point. Unlike ctucanfd and xilinx_can, which reset
the controller in open() before napi_enable(), ifi_canfd_open() does not
quiesce the IP first, the handler is registered with IRQF_SHARED, and the
ISR acts on the raw IFI_CANFD_INTERRUPT status. So on the first open after
boot or kexec, the poll can now be scheduled before or during
ifi_canfd_start().

In v2 I plan to call ifi_canfd_stop() in ifi_canfd_open() before
request_irq(), so the IP is reset, its interrupts are masked and pending
status is cleared before the handler is installed and NAPI is enabled.

The bus-off restart path through ifi_canfd_set_mode() already runs with
NAPI enabled. I will leave that alone in this series.

I will wait a few days for other comments on the series before sending v2.

pw-bot: cr
