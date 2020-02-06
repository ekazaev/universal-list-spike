//
// Created by Eugene Kazaev on 06/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit

public final class UITableViewDelegateSplitter: NSObject, UniversalListDelegateController, UITableViewDelegate {

    public typealias View = UITableView

    public let tableViewDelegate: UITableViewDelegate?

    public let scrollViewDelegate: UIScrollViewDelegate?

    public init(tableViewDelegate: UITableViewDelegate?, scrollViewDelegate: UIScrollViewDelegate?) {
        self.tableViewDelegate = tableViewDelegate
        self.scrollViewDelegate = scrollViewDelegate
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        tableViewDelegate?.tableView?(tableView, willDisplayHeaderView: view, forSection: section)
    }

    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        tableViewDelegate?.tableView?(tableView, willDisplayFooterView: view, forSection: section)
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        tableViewDelegate?.tableView?(tableView, didEndDisplayingHeaderView: view, forSection: section)
    }

    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        tableViewDelegate?.tableView?(tableView, didEndDisplayingFooterView: view, forSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewDelegate?.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewDelegate?.tableView?(tableView, heightForHeaderInSection: section) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableViewDelegate?.tableView?(tableView, heightForFooterInSection: section) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return tableViewDelegate?.tableView?(tableView, estimatedHeightForHeaderInSection: section) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return tableViewDelegate?.tableView?(tableView, estimatedHeightForFooterInSection: section) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewDelegate?.tableView?(tableView, viewForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableViewDelegate?.tableView?(tableView, viewForFooterInSection: section)
    }

    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, accessoryButtonTappedForRowWith: indexPath)
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return tableViewDelegate?.tableView?(tableView, shouldHighlightRowAt: indexPath) ?? true
    }

    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, didHighlightRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, didUnhighlightRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return tableViewDelegate?.tableView?(tableView, willSelectRowAt: indexPath) ?? indexPath
    }

    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return tableViewDelegate?.tableView?(tableView, willDeselectRowAt: indexPath) ?? indexPath
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return tableViewDelegate?.tableView?(tableView, editingStyleForRowAt: indexPath) ?? .none
    }

    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return tableViewDelegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return tableViewDelegate?.tableView?(tableView, leadingSwipeActionsConfigurationForRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return tableViewDelegate?.tableView?(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return tableViewDelegate?.tableView?(tableView, shouldIndentWhileEditingRowAt: indexPath) ?? true
    }

    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, willBeginEditingRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableViewDelegate?.tableView?(tableView, didEndEditingRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return tableViewDelegate?.tableView?(tableView, targetIndexPathForMoveFromRowAt: sourceIndexPath, toProposedIndexPath: proposedDestinationIndexPath) ?? proposedDestinationIndexPath
    }

    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return tableViewDelegate?.tableView?(tableView, indentationLevelForRowAt: indexPath) ?? 0
    }

    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return tableViewDelegate?.tableView?(tableView, canFocusRowAt: indexPath) ?? true
    }

    public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return tableViewDelegate?.tableView?(tableView, shouldUpdateFocusIn: context) ?? true
    }

    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        tableViewDelegate?.tableView?(tableView, didUpdateFocusIn: context, with: coordinator)
    }

    public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return tableViewDelegate?.indexPathForPreferredFocusedView?(in: tableView)
    }

    public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return tableViewDelegate?.tableView?(tableView, shouldSpringLoadRowAt: indexPath, with: context) ?? false
    }

    public func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return tableViewDelegate?.tableView?(tableView, shouldBeginMultipleSelectionInteractionAt: indexPath) ?? false
    }

    public func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        tableViewDelegate?.tableView?(tableView, didBeginMultipleSelectionInteractionAt: indexPath)
    }

    public func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        tableViewDelegate?.tableViewDidEndMultipleSelectionInteraction?(tableView)
    }

    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return tableViewDelegate?.tableView?(tableView, contextMenuConfigurationForRowAt: indexPath, point: point)
    }

    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return tableViewDelegate?.tableView?(tableView, previewForHighlightingContextMenuWithConfiguration: configuration)
    }

    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return tableViewDelegate?.tableView?(tableView, previewForDismissingContextMenuWithConfiguration: configuration)
    }

    public func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        tableViewDelegate?.tableView?(tableView, willPerformPreviewActionForMenuWith: configuration, animator: animator)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidZoom?(scrollView)
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        scrollViewDelegate?.viewForZooming?(in: scrollView)
    }

    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollViewDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollViewDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }

    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        scrollViewDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
    }

    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScrollToTop?(scrollView)
    }

    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
    }

}
