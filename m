Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D74854F8;
	Tue,  4 Aug 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873376; cv=none; b=szyB60Bqpc0vtiQzPm7x5arKPUnkoyWfoMcjEWAmXLe/HJn9lK+VKJ8k365fxdQH7lElj7jPqQMlyVYF4lBHQ23DYw5pNLVACeLg2ZaATDHcCeWkyT5KQQXwIsDRm5VSGWUbaZiRyoTMcvhmTbEcInohhJhgYk8ig2n3DNJVQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873376; c=relaxed/simple;
	bh=AGBf41rbw9xUKOej5tMAjXMh+Zf92Wr1uWCUIxoBjJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L50NyhrvXPPQktepdwc+sos6lYngslx1uLKllZqI9dXSMIPS2GpjI/0aYsgEoCO4ZOln6Mk6zoka7tiX391aTZrT1+RqLvQE6z03X9AbEkIuZegBkNllvx8fVeB4tVEByF8Ph7/T3ndmecjPZL1dC1wqNry2t933Ys3azOWYyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuFPTJvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuFPTJvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA901F000E9;
	Tue,  4 Aug 2026 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873375;
	bh=MHjWPaO3ZiovOgqzK0y22iMM1JEQ1cEhkGKkY16pdIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RuFPTJvBpmjeREDktlU0Oblxkh8RMuuU+x1VnSyf5k5urtPnKLk8sAjW6Rm1o8kyQ
	 BkeIFiAw4S1xGPFCYHv1PeqScu/9hgQ1qLIWL3nkZT5IU7hlm1OqMFDbjd4F9MfWip
	 J4bMUD0ce+fag+TGRdQCSiOX6YKHWZvW/RF/emILNMVRGdYR4ShW1M5a5mPkHNMyN+
	 K2aUDzPtR7GgmA49dzAw7Zt6tcrzoOjqQmQjijYPGfo939F9O2LreOQ87qfEjEfXfN
	 1eyoBV375DT207pWq+uQk/5IHKbrrbsHHGcdlJf1FKbAc5kFtT1josESb0HP7bI7t4
	 2I4IvQku10YYQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 04 Aug 2026 21:55:25 +0200
Subject: [PATCH 2/4] can: fix IFF_ECHO example in documentation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-automate_iff_echo_flag-v1-2-26f06ff0f8bc@kernel.org>
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
In-Reply-To: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=AGBf41rbw9xUKOej5tMAjXMh+Zf92Wr1uWCUIxoBjJ4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlFzjdipL0mBt/XTTPtev7QqE8nnNGmTbCscPu8bU5hE
 ccY7c07JrIwiHExWIopsiwr5+RW6Cj0Djv01xJmDisTyBBpkQYGIGBh4MtNzCs10jHSM9U21DME
 MnSMGLg4BWCqT21mZLixUjwj9+ZM+b/GLYfSnyjVac4yd/I6eUyuOVbw8ueKB80Mf7j0vzreYv8
 RvJtl7eaE0Kkuv4P8Kw5xJzrZ58/UvmCawQcA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The documentation suggests doing:

  dev->flags = (IFF_NOARP | IFF_ECHO);

to set the IFF_ECHO flag. This is problematic because by doing so,
other potentially enabled flags would be overwritten. Furthermore,
none of the drivers do it like that.

Replace the example by:

  dev->flags |= IFF_ECHO;

which is more robust and consistent with what all the drivers are doing.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 Documentation/networking/can.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d..fbd0d501ea4e 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1126,7 +1126,7 @@ e.g. of tty devices. In this case the driver flag IFF_ECHO has to be
 set to prevent the PF_CAN core from locally echoing sent frames
 (aka loopback) as fallback solution::
 
-    dev->flags = (IFF_NOARP | IFF_ECHO);
+    dev->flags |= IFF_ECHO;
 
 
 CAN Controller Hardware Filters

-- 
2.54.0

