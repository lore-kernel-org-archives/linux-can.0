Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8361B4C43
	for <linux-can@vger.kernel.org>; Thu, 20 Jun 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907244; cv=none; b=dU0sB9s9xRvLmB5QLeXoWcjm4JHn+s6AGmEvphdZxQOe1JANZ1ZYsIfN8+Nfl8KEDUma1WAQ7yHI2CY3RIdO3MH5+/U1vOQLuLK5QIG7z/pmsFUnIPyzG1b7oH0Ihu4j4+fxAcwjny32gu3iwIlzvtTBh/KeQCS+s0wKh/6Aj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907244; c=relaxed/simple;
	bh=PE2v+agIxWL6NLcFXSVq7TQPBUAkZYaXpGJCxl7qu4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IfHHnKsTJDo68N3Joe5BR9QlfDMq8NIGrr/tknzyZ+2flXCIdajFxbO+/L/I9YjEU7tdWrOZMLvcSGPy4FcPfhbsGa5mVpBLk5P1KJaUXI5riLMoJXXG9HKlDI+Ctz24C1dJHCQ5J1iD7k7aAe8ZUEjTf/W2ul2Fi6WK24ZL9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Z+gPuKQw; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Z+gPuKQw"
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id E66A7E00FF;
	Thu, 20 Jun 2024 20:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1718907232; bh=PE2v+agIxWL6NLcFXSVq7TQPBUAkZYaXpGJCxl7qu4s=;
	h=From:To:Cc:Subject:Date:From;
	b=Z+gPuKQw1yqKbisKvHTUxxDqfjueBH8u19a1hdPyP5oSX6Nt6fwTJaW+y01i9oeYK
	 RCDcrLcNOj0c/4jVEWXkCq8kfo1b19OwEq/EzMj7csm1z97yLwoazgYhJ0X3O804yq
	 j1l1BMbU+bbsDBD9VImXARU4fw3O21XppGT2xXK/IQ4bYpu529ZL7SzHEAxiiFPgc+
	 RN1knOtF9Pxu2NY5L1KVF7X/2njmwckmD7JVnO/KlJjXPIz8BzDW18CfaZjtoJj+jU
	 /HD5UpSYE2iU17VJx6C8PTs2WnaI3mXbWoOnCePSMye/U+q2IMCnq9xEEHCqb3syK6
	 5Ftosvr03TA5Q==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH v2 0/2] can: kvaser_pciefd: Support MSI interrupts
Date: Thu, 20 Jun 2024 20:13:18 +0200
Message-Id: <20240620181320.235465-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for MSI interrupts. It depends on
the patch series can: kvaser_pciefd: Minor improvements and cleanups.

Martin Jocic (2):
  can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
  can: kvaser_pciefd: Add MSI interrupts

 drivers/net/can/kvaser_pciefd.c | 55 +++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 16 deletions(-)

-- 
2.40.1

