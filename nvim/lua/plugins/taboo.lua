return {
  "gcmt/taboo.vim",
  config = function()
    vim.cmd([[
      function TabWithName(Func)
      call inputsave()
      let l:NewTabName = input("tab name: ")
      call inputrestore()
      execute a:Func . l:NewTabName . " "
      endfunction

      function NewTabWithName()
        call TabWithName("TabooOpen ")
        endfunction
      command! NewTabWithName :call NewTabWithName()

      function RenameTab()
        call TabWithName("TabooRename ")
        endfunction
      command! RenameTab :call RenameTab()

      function NewTabWithNoName()
        execute "TabooOpen " . "new_tab"
        endfunction
      command! NewTabWithNoName :call NewTabWithNoName()

      function SetupTabs()
        execute "TabooRename controller "
        execute "TabooOpen action "
        execute "TabooOpen service "
        execute "TabooOpen repo "
        execute "TabooOpen view "
      endfunction
      map <silent> <C-T>s :call SetupTabs()<CR>

      map <silent> <C-T>n :NewTabWithName<CR>
      map <silent> <C-T>t :NewTabWithNoName<CR>
      map <silent> <C-T>, :RenameTab<CR>
      map <silent> <C-T>q :tabclose<CR>

      let g:taboo_tab_format = "%N - %f"
      let g:taboo_renamed_tab_format = "[%N%m] %l"
  ]])
  end,
}
