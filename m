Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFE40BCB6;
	Wed, 17 Jun 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703533; cv=none; b=X3pHlE9PhHEeUJNsUHks9yIuGhYplFymjD4RGotE4j2ZFm38INGHhfnA+owT7dZUpd7XSjcEtPsXLDer1W5U/0GjCbsEcq0UZQyCcFy52ebXKHo+9wERaipZMfmJxHjt2+pfOUVOtXKt68tRFHI4W0Cj8gDe1CPqSNgd8kB5j84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703533; c=relaxed/simple;
	bh=R7Bf4XwxXcBmoaEbPhDRg6MQURq+Gk+znSviWBXEyQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NnA7H1NyKjvaba2wCZXAaJQNz4AmfTfRqBe//MPawLNEhKIBZCZFqoeyz2HKPQXWGA6Mg76jboV1EadDRM3x8Y21G4z/lqoKXFXOEYoOYJh0I1RXW9q2lQfJB2JshvBHLhgQXvZUB0237HY56aN3fsGeVI/cw+HMmNRSX27C1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4F9EuMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4F9EuMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C36C1F000E9;
	Wed, 17 Jun 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703531;
	bh=6Mni33sR6cHey5x/QsVXQJR7xUylFERVrUN1i7Rxnlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d4F9EuMbrV/i2sSK9xruPZf2fv91FBo+13vupEFiOdzgkCLngt+zveNQtyNW2Xy/f
	 Idt2z5pqd+UpKznJJgANkebVyPdf/DJKtQ8ob0uMa4w8alHi0byu/JkekaNgiMojb/
	 ndiP51tpZrWMPdz3ZELHHWH/sU02Fh0Vq7Pf4AsZZnCRCM+kVkkJBk6nwNVbZHnCZQ
	 jXDHiiDKfB5dINdxAHpBKKRU86Md6avppLLBJ0VuBTuz0hdEiNMOTSA457iBivZm1a
	 Fmw/axUBoUQga0/DqtOQL7MpbMDwslPl2IGnpArHrdyu6qva4K6gQd3DEzGWCjmgWj
	 OM2h2VsPz72rA==
From: Mark Brown <broonie@kernel.org>
To: sashiko-bot@kernel.org, mkl@pengutronix.de, 
 guoqi0226 <guoqi0226@163.com>
Cc: linux-can@vger.kernel.org, mailhol@kernel.org, o.rempel@pengutronix.de, 
 sashiko-reviews@lists.linux.dev, socketcan@hartkopp.net, 
 linux-spi@vger.kernel.org
In-Reply-To: <20260616103018.105612-1-guoqi0226@163.com>
References: <20260616103018.105612-1-guoqi0226@163.com>
Subject: Re: (subset) [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID
 table for MCP251XFD
Message-Id: <178160960261.55685.12204073262177758524.b4-ty@b4>
Date: Tue, 16 Jun 2026 12:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=broonie@kernel.org;
 h=from:subject:message-id; bh=R7Bf4XwxXcBmoaEbPhDRg6MQURq+Gk+znSviWBXEyQw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqMqNojnRhzxjoez7sJ17/WcSoAw7IeDPvoQS4P
 N7+hgrD4UqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajKjaAAKCRAk1otyXVSH
 0ACHB/47jaoMxZ3OmOPDU34TqWyD/r1iVbq6ZZQPi9fHJpRoZkyweLi5DYfiGPxNYsdub9jUBTb
 K6fRkifC0Jr/l6WOjjynDkkifvk/nfAXv2d1B+MwaL3oYC53jAQWyYi8M8A4oh+1koFyy9IfoIh
 AmfY1yGFRcm01xSn8XwaP43NgcvrkdTIGI1YSwn7SrOhtDCH/WKDf3kIuCn+4onSEBATGH0UTUY
 fbqTdi9dXfKW0VdW1lRCe5qTxD3Qkf1wao+UT3YybjCFCRb/mxhT1ZKl8bY3/XVmjJSTFvfI0co
 Y1vB9QJWjH1fkKQ8igbizYnoKVJ6W1OElj/oVDTfoz8QCnmJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 16 Jun 2026 18:30:16 +0800, guoqi0226 wrote:
> can: mcp251xfd: Add ACPI device ID table for MCP251XFD
> 
> hanges in v4:
> - Split into two separate patches:
>   1. SPI core: add internal NULL guard for spi_get_device_match_data()
>   2. mcp251xfd driver: cache and validate match data pointer in probe
> - Remove duplicate spi_get_device_match_data() invocation and unsafe dereference
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[2/2] spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()
      https://git.kernel.org/broonie/spi/c/0f82535b5537

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

