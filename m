Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510687;
	b=eV5U4Yo/jj+NqGjK3LyOz/c1Wn5K9B58xd2yX27Fp/Lt/7RNkPjf9qGYxXtiGDTcg8ht
	 mbkCnT5VEQj1S/9bz3nr97LrRFWU0GSxCNFeTMz0+kOD1nOE2qVsScDSXWZBnqVKs6uTj
	 jg2v2GlJWVyxpMSxO8bCa859lNkwPAwl9qKbhy4ivhhDO31HZZlIK5/DrI/cyRSqAO7QD
	 Qaizj5SiWTRNhUfxEpoeqC3qfZL3WzDXGLjF6mk6lFD+f+KQmecKeDOhRImOH+uIoB4jj
	 9ff2WES3tM3Ra3OMxnhjJSc/jFM4zleoetGvDFvUidMgozSOhjwflXs8sAU2qwX8O3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510687;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2gtqNlx/WsnInoEEg5ohVEynPC/Kc7s2Lw7tPAfJGqM=;
	b=dUUq2je866qy8nBIXoz6YS1ShkTQxYtcTZGIppyedxe7+gWf/IC7oVcgSJcHSMOKkrAu
	 +p1RhfVfhXVfZFUQgfmD6YvffH2Z+f9bEeqZljJoQqxJDBTFHw5OyWxOFPDePfl8Gghox
	 C+9uGv9vrmdugYIMUVvx+Phjg0M13PBIyAoNxmjRugVT5phJys+nNfDkfWJIfdANM2ViS
	 RG68vme0pPuvEY9+6Pr1cw5z1ct1pNCGh/a8i1fXf6IsqkrBMUmXU5Vi2iLRilWC2VL4C
	 iT5hNWpk6IT+adQ8Rg7csg/TdeTeue8oN2q/NWZhNlgQ2fBBhOAnhyjg+d6gsBB+C/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EnDJtaGT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE4606A33D;
	Tue, 24 Nov 2026 08:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FE4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EnDJtaGT
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D9A79200037;
	Tue, 24 Nov 2026 09:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2gtqNlx/WsnInoEEg5ohVEynPC/Kc7s2Lw7tPAfJGqM=;
	b=EnDJtaGTznNTbrMebVOv3MlV/HmaOGP1VJ25yTW2u37fMX3Z/p4sRt5YbCGakFSrwBrKzc
	iYzj8ZGIQm9pmpptTztQGYBlT4aNTNhQ0fNIjXxUJ8RCxyYSH7EISFhuVFg9TRvJvg5XB/
	As8ka9vEuInhRyuQ1ErobYtHs4SNt5y7ug5WfM8R9DJE+RkGzxrrEDFouRXyNNtzKbJnYV
	mBHdYwQqYGN7/NgRtCYk8E7U4xIM44FVlXdnOw/ugKgBXT/Zpm5DivAWOFe4cF+8zK5NsH
	C/OG3rU5Qge9atDb36AoL7jJ6QOJB+Fc9F8nWy2p7UDXGjXN3FR4vLfGAe90Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2gtqNlx/WsnInoEEg5ohVEynPC/Kc7s2Lw7tPAfJGqM=;
	b=cCQzMruTlpfBoaQG0nWrX+e7sfPyAgMMxaavkH5m5A+FT7ZB0bwxK11DHstMobZtLFc+VO
	FDNP/1H7X33P2WhE7p0qhEl+vzgnylLaEOoJTEFCw94S8ol7imFkjIjeKHwP8un0on8MCo
	FJ/06S+g4MrEwJanWDp735vJF4kFroyFQvpIImyUueDDEUNNCx9aTgMe36IAXEqWTsHTvf
	jGTtHFiNeisiK4YukaR+4FQAVOvoI6zCnMF0RKaj1CG5tlsf+tk7P1rSiPEnk/G50t+fs1
	14dHOTRBRf1czXpJL2ZE3Hb0r4fuF0xX+M2pQuncWiwIDilTrcatw6WLAeLj1g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510684; a=rsa-sha256;
	cv=none;
	b=C6YCX+xGVLdn9SD8ySJl2tvOkdhTWPlq+aYNBq9ub7xWAlvFejjgV2z/aPfiyQkp7d3TiF
	LrxsUokfdvPISlnDFcBcjgUIn1W2fXqgKqv0r+OH+tmFIMKKA1qjT9Zh/gTEQRcBxwRvd4
	o41W3iJI26LJ7ty/Yf9u6vd+TXAdVaSL/rslqJrxL3CIQ+jhR4/KjRJgVMBR+ltO73Sq78
	5+xp3M+nNZshi25ijMKhq+M4rk9xlVbU0WCGmHUll2SeWx+zxaG1CLeou3Uq/Y599Lh6Xe
	NMmOlmmtlefng6RaVm1vN1H3RrKNvdCqPaZk+wyIaAroZsWsKKG349C1Q1+/BQ==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/12] pull-request: can 2026-11-24
Date: Tue, 24 Nov 2026 09:51:27 +0100
Message-ID: <20261124085757.1093632-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 12 patches for net/main.

The first 7 patches are by Oliver Hartkopp and avoid RTNL stalls in
CAN_RAW, CAN_ISOTP and CAN_BCM protocols and fix CAN_ISOTP issues.

Followed by 3 patches are by Zhu Ling that fix problems with the CAN
netlink handling.

A patch by my fixes a kernel memory information leak over USB in the
gs_usb driver.

Uwe Kleine-König contributes a patch to the flexcan driver to fix
probing for m68k/coldfire.

regards,
Marc

====

The following changes since commit 4392bb809812ac79449cd0cf1f5e00469ee102d1:

  Merge branch 'ionic-fix-tx-stalls-on-tso-skbs-larger-than-the-tx-ring' (2026-11-23 18:00:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.4-20261124

for you to fetch changes up to 8691992932377570ec79cbeb2ce5f24748bfe698:

  can: flexcan: Fix probing for m68k/coldfire (2026-11-24 09:38:46 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.4-20261124

----------------------------------------------------------------
Marc Kleine-Budde (2):
      Merge patch series "can: avoid RTNL stalls and fix CAN_ISOTP and netlink issues"
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB

Oliver Hartkopp (7):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()
      can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
      can: isotp: reject socket options while a transfer is active

Uwe Kleine-König (The Capable Hub) (1):
      can: flexcan: Fix probing for m68k/coldfire

Zhu Ling (3):
      can: netlink: fix static FD-NON-ISO mode validation
      can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
      can: netlink: fix CAN XL PWM attribute sizing

 drivers/net/can/dev/netlink.c          |  22 +++++--
 drivers/net/can/flexcan/flexcan-core.c |  12 +++-
 drivers/net/can/usb/gs_usb.c           |   2 +-
 net/can/bcm.c                          | 114 +++++++++++++++++++++++----------
 net/can/isotp.c                        |  81 ++++++++++++++---------
 net/can/raw.c                          |  41 ++++++------
 6 files changed, 181 insertions(+), 91 deletions(-)
